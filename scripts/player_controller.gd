extends CharacterBody2D



func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("Left", "Right", "Up", "Down") * speed
	
	if velocity:
		if velocity.x > 0:
			$AnimatedSprite2D.play("right")
		elif velocity.x < 0:
			$AnimatedSprite2D.play("left")
		elif velocity.y > 0:
			$AnimatedSprite2D.play("down")
		elif velocity.y < 0:
			$AnimatedSprite2D.play("up")
	else:
		$AnimatedSprite2D.play("idle")
			
	handle_collision(move_and_collide(velocity * delta))

func handle_collision(res) -> void:
	if res:
		pass
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
		
