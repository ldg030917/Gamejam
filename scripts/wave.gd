extends Node2D

@onready var sprite = $Sprite2D

func _process(delta: float) -> void:
	scale += Vector2(4, 4)*delta
	sprite.modulate.a -= delta
	
func launch(origin : Vector2, B : bool, G : bool, R : bool):
	global_position = origin
	if B : 
		sprite.modulate.b = 1
	else :
		sprite.modulate.b = 0.3
	if G :
		sprite.modulate.g = 1
	else :
		sprite.modulate.g = 0.3
	if R :
		sprite.modulate.r = 1
	else :
		sprite.modulate.r = 0.3

func _on_vanish_timer_timeout() -> void:
	queue_free()
