extends Node2D

func _process(delta: float) -> void:
	scale += Vector2(2, 2)*delta
	
func launch(origin : Vector2):
	global_position = origin

func _on_vanish_timer_timeout() -> void:
	queue_free()
