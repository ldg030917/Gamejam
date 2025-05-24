extends StaticBody2D

func _ready() -> void:
	$Sprite2D.modulate.a = 0

func set_alpha(alpha: float) -> void:
	$Sprite2D.modulate.a = alpha+0.1

func _process(delta: float) -> void:
	$Sprite2D.modulate.a -= delta*0.4
	if global.B and is_in_group("water") :
		$Sprite2D.modulate.b = 1.0
		set_collision_layer_value(2, false)
	elif global.G and is_in_group("vine") :
		$Sprite2D.modulate.g = 1.0
		set_collision_layer_value(2, false)
	elif global.R and is_in_group("flame") :
		$Sprite2D.modulate.r = 1.0
		set_collision_layer_value(2, false)
	else :
		set_collision_layer_value(2, true)
		$Sprite2D.modulate.b = 0.5
		$Sprite2D.modulate.g = 0.5
		$Sprite2D.modulate.r = 0.5
