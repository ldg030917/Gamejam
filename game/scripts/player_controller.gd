extends CharacterBody2D

@export var speed = 200

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("Left"):
		position.x -= speed * delta
	if Input.is_action_pressed("Right"):
		position.x += speed * delta
	if Input.is_action_pressed("Up"):
		position.y -= speed * delta
	if Input.is_action_pressed("Down"):
		position.y += speed * delta
