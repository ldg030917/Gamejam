extends StaticBody2D

func set_alpha(alpha: float) -> void:
	$Sprite2D.modulate.a = alpha+0.1

func _process(delta: float) -> void:
	$Sprite2D.modulate.a -= delta*0.4
