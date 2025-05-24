extends Area2D

@export var clockwise = true
@export var speed = 0.7

func _ready() -> void:
	modulate.a = 0
	
func _on_body_entered(body):
	if body is Player:
		body.die()

func set_alpha(alpha: float) -> void:
	modulate.a = alpha+0.1

func _process(delta: float) -> void:
	modulate.a -= delta*0.4
	if clockwise : 
		rotation -= speed * delta
	else :
		rotation += speed * delta
	
