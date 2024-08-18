extends CanvasLayer


# Notifies `Main` node that the button has been pressed
signal start_game
signal end_game


# Called when the node enters the scene tree for the first time.
func _ready():
	#$HealthBar.hide()
	$Control/MarginContainer/DaytimeBar.hide()


func show_message(text):
	$Control/MarginContainer/VBoxContainer/MessageLabel.text = text
	$Control/MarginContainer/VBoxContainer/MessageLabel.show()
	$MessageTimer.start()


func show_game_over(player_has_won):
	if player_has_won:
		show_message("WINNER!")
	else:
		show_message("YOU HAVE DIED")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Control/MarginContainer/VBoxContainer/MessageLabel.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1).timeout
	$Control/MarginContainer/VBoxContainer/StartButton.show()


func update_daytime(daytime):
	$Control/MarginContainer/DaytimeBar.value = daytime
	$Control/ClockTexture
	$Control/SpinnerTexture.rotation_degrees = move_toward($Control/SpinnerTexture.rotation_degrees, 180, 50)
	if $Control/SpinnerTexture.rotation_degrees == 180:
		end_game.emit(false)


func update_health(health):
	var tween = get_tree().create_tween()
	tween.tween_property($Control/MarginContainer/HealthFullRect, "custom_minimum_size", $Control/MarginContainer/HealthFullRect.size - Vector2(16, 0), 0.25)
	#$HealthBar.value = health


func _on_start_button_pressed():
	$Control/MarginContainer/VBoxContainer/StartButton.hide()
	#$HealthBar.show()
	#$Control/MarginContainer/DaytimeBar.show()
	start_game.emit()


func _on_message_timer_timeout():
	$Control/MarginContainer/VBoxContainer/MessageLabel.hide()
