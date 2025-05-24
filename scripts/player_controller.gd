extends CharacterBody2D

@export var speed = 200
@export var n_particle = 120
var emit_on = false
var R = false
var G = false
var B = false
@onready var wave = preload("res://scenes/wave.tscn")
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if emit_on :
		change_arrow()
	else :
		velocity = Input.get_vector("Left", "Right", "Up", "Down").normalized()
	
	if velocity:
		if velocity.x > 0 :
			$AnimatedSprite2D.play("right")
		elif velocity.x < 0 :
			$AnimatedSprite2D.play("left")
		elif velocity.y > 0 :
			$AnimatedSprite2D.play("down")
		elif velocity.y < 0 :
			$AnimatedSprite2D.play("up")
	else:
		$AnimatedSprite2D.play("idle")
			
	handle_collision(move_and_collide(velocity * speed * delta))

func handle_collision(res) -> void:
	if res:
		pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Emit") :
		emit_on = !emit_on
	if Input.is_action_pressed("Blue") :
		B = !B
	if Input.is_action_pressed("Green") :
		G = !G
	if Input.is_action_pressed("Red") :
		R = !R
	sprite.modulate.b = 1.0 if B else 0.5
	sprite.modulate.g = 1.0 if G else 0.5
	sprite.modulate.r = 1.0 if R else 0.5
	

func _process(delta: float) -> void:
	if emit_on and $WaveCool.time_left == 0 :	
		var wave = wave.instantiate() as Node2D
		get_tree().root.add_child(wave)
		wave.launch(global_position, B, G, R)
		$WaveCool.start()
		
func change_arrow() :
	if B and G and R :
		velocity = Vector2(0, 0)
	elif B and G:
		velocity = Input.get_vector("Up", "Right", "Down", "Left").normalized()
	elif G and R :
		velocity = Input.get_vector("Up", "Down", "Left", "Right").normalized()
	elif B and R :
		velocity = Input.get_vector("Left", "Down", "Right", "Up").normalized()
	elif B :
		velocity = Input.get_vector("Left", "Right", "Down", "Up").normalized()
	elif G :
		velocity = Input.get_vector("Up", "Right", "Left", "Down").normalized()
	elif R :
		velocity = Input.get_vector("Left", "Down", "Up", "Right").normalized()
	else :
		velocity = Input.get_vector("Right", "Left", "Up", "Down").normalized()
	
