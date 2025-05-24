extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		global.fragment += 1
		queue_free()
