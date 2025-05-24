extends CharacterBody2D

@export var horizontal = true
@export var speed = 150
var direction = 1

func _ready() -> void:
	$Sprite2D.modulate.a = 0
	
func _physics_process(delta: float) -> void:
	if horizontal :
		velocity = Vector2(speed*delta, 0)
	else :
		velocity = Vector2(0, speed*delta)
	
	var collision = move_and_collide(velocity*direction)
	
	if collision :
		direction *=-1
		var collider = collision.get_collider()
		if collider.is_in_group("player") :
			collider.die()

func set_alpha(alpha: float) -> void:
	$Sprite2D.modulate.a = alpha+0.1

func _process(delta: float) -> void:
	$Sprite2D.modulate.a -= delta*0.4
	
