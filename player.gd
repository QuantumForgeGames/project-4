extends Area2D


signal died
signal hit
signal won


@export var speed: float = 8.0
@export var acceleration: float = 30


var health: int = 3
var can_move: bool
var footstep_frames: Array = [1]


func _ready():
	hide()


func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.length() > 0 and can_move:
		velocity = direction.normalized().move_toward(speed*direction, acceleration)
		$AnimatedSprite2D.play()
	
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_right"
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "walk_left"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
		
	if velocity.length() == 0 or can_move == false:
		$AnimatedSprite2D.stop()


	position += velocity


func start(pos):
	position = pos
	health = 3
	show()
	$CollisionShape2D.disabled = false
	can_move = true


func respawn():
	blink_red()
	await get_tree().create_timer(.5).timeout
	can_move = true


# TODO Clean this up.
func blink_red():
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, .1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1) , .1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, .25).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1) , .1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, .25).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1) , .1).set_trans(Tween.TRANS_SINE)


func _on_area_entered(area):
	$HitSFXPlayer.play()
	can_move = false
	if area.name == "GoalArea":
		hide()
		won.emit(true)
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		health -= 1
		hit.emit()
		if health > 0:
			respawn()
		else:
			hide()
			died.emit(false)
			$CollisionShape2D.set_deferred("disabled", true)


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.frame in footstep_frames:
		$MovementSFXPlayer2D.play()
