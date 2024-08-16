extends Node


var daytime: int
var map_rect
var tile_size
var world_size_in_pixels


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
	map_rect = $TileMap.get_used_rect()
	tile_size = $TileMap.rendering_quadrant_size
	world_size_in_pixels = map_rect.size * tile_size
	$Player/Camera2D.limit_right = world_size_in_pixels.x
	$Player/Camera2D.limit_bottom = world_size_in_pixels.y


func _on_start_timer_timeout():
	$DaytimeTimer.start()


func _on_daytime_timer_timeout():
	daytime -= 1
	$HUD.update_daytime(daytime)


func update_health():
	$HUD.update_health($Player.health)
