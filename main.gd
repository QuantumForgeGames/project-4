extends Node


var daytime: int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over(player_has_won):
	print(player_has_won)
	$DaytimeTimer.stop()
	$HUD.show_game_over(player_has_won)


func new_game():
	daytime = 100
	$Player.start($StartMarker.position)
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
