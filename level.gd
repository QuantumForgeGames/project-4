extends Node2D


func _on_arrow_timer_timeout():
	var tween = get_tree().create_tween()
	if $ArrowSprite.modulate.a == 1:
		tween.tween_property($ArrowSprite, "modulate:a", 0, 0.25)
	else:
		tween.tween_property($ArrowSprite, "modulate:a", 1, 0.25)

func update_sky():
	var tween = get_tree().create_tween()
	tween.tween_property($SkyCanvas, "color", Color("6d3190"), 25)
