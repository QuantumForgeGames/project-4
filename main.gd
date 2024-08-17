extends Node


var daytime: int


func _process(delta):
	if $BackgroundMusic.playing == false:
		$BackgroundMusic.play()
	if $BackgroundSFX.playing == false:
		$BackgroundSFX.play()	


func game_over(player_has_won):
	print(player_has_won)
	$DaytimeTimer.stop()
	$HUD.show_game_over(player_has_won)


func new_game():
	daytime = 100
	$Player.start($Level/StartMarker.position)
	$StartTimer.start()
	$HUD.update_daytime(daytime)
	$HUD.update_health($Player.health)
	$HUD.show_message("Get Ready")


func _on_start_timer_timeout():
	$DaytimeTimer.start()


func _on_daytime_timer_timeout():
	daytime -= 1
	$HUD.update_daytime(daytime)


func update_health():
	$HUD.update_health($Player.health)
