extends Node2D

@onready var sprite = $Sprite2D

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("body_entered", Callable(self, "_on_body_entered"))

func _process(delta: float) -> void:
	scale += Vector2(8, 8)*delta
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


func _on_body_entered(body):
	if body.is_in_group("Tile"):
		body.set_alpha($Sprite2D.modulate.a)
		
