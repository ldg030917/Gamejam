extends StaticBody2D

func set_alpha(alpha: float) -> void:
	$Sprite2D.modulate.a = alpha+0.1

func _process(delta: float) -> void:
	$Sprite2D.modulate.a -= delta*0.4
	if ((global.B and is_in_group("water")) or
		(global.G and is_in_group("vine")) or
		(global.R and is_in_group("flame"))) :
		set_collision_layer_value(2, false)
	else :
		set_collision_layer_value(2, true)
