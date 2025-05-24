extends Area2D

func _ready() -> void:
	$Sprite2D.modulate.a = 0
	connect("body_entered", _on_body_entered)
	
func _on_body_entered(body):
	if body is Player:
		body.die()

func set_alpha(alpha: float) -> void:
	$Sprite2D.modulate.a = alpha+0.1

func _process(delta: float) -> void:
	$Sprite2D.modulate.a -= delta*0.4
