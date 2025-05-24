extends CharacterBody2D

@export var speed = 200

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
