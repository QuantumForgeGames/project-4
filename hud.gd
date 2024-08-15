extends CanvasLayer


# Notifies `Main` node that the button has been pressed
signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.hide()
	$DaytimeBar.hide()


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over(player_has_won):
	if player_has_won:
		show_message("WINNER!")
	else:
		show_message("YOU HAVE DIED")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$MessageLabel.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func update_daytime(daytime):
	$DaytimeBar.value = daytime


func update_health(health):
	$HealthBar.value = health


func _on_start_button_pressed():
	$StartButton.hide()
	$HealthBar.show()
	$DaytimeBar.show()
	start_game.emit()


func _on_message_timer_timeout():
	$MessageLabel.hide()
