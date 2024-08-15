extends Area2D


signal died
signal hit
signal won


@export var speed: float = 2.0
@export var acceleration: float = 30


var health: int = 3
var can_move: bool


func _ready():
	hide()


func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.length() > 0 and can_move:
		#velocity.x = move_toward(velocity.x, speed * direction.x, acceleration)
		#velocity.y = move_toward(velocity.y, speed * direction.y, acceleration)
		velocity = direction.normalized().move_toward(speed*direction, acceleration)
		# Play animation
	else:

		pass
		# Stop Animation
	if Input.is_action_pressed("move_up"):
			$AudioStreamPlayer.play()
		
	# More Animation Stuff
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "walk"
		#$AnimatedSprite2D.flip_v = false
	# See the note below about the following boolean assignment.
	#$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
		#$AnimatedSprite2D.flip_v = velocity.y > 0


		
		
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
	# Find where to respawn the player


func blink_red():
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, .1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1) , .1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, .25).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1) , .1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, .25).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1) , .1).set_trans(Tween.TRANS_SINE)



func _on_area_entered(area):
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


func _on_hit():
	print("I GOT HIT!!!")
