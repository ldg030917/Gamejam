extends CharacterBody2D

@export var speed = 100
@export var n_particle = 120
var emit_on = false
@onready var wave = preload("res://scenes/wave.tscn")
	
func _process(delta):
	if Input.is_action_pressed("Left"):
		position.x -= speed * delta
	if Input.is_action_pressed("Right"):
		position.x += speed * delta
	if Input.is_action_pressed("Up"):
		position.y -= speed * delta
	if Input.is_action_pressed("Down"):
		position.y += speed * delta
		
	if emit_on and $WaveCool.time_left == 0:	
		var wave = wave.instantiate() as Node2D
		get_tree().root.add_child(wave)
		wave.launch(global_position)
		$WaveCool.start()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Emit") :
		emit_on = !emit_on
		
