extends CharacterBody2D
class_name Player

@export var speed = 230
@export var n_particle = 120
var emit_on = false
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
			
	var collision = move_and_collide(velocity * speed * delta)
	
	if collision :
		var collider = collision.get_collider()
		if collider.is_in_group("saw") or collider.is_in_group("laser"):
			die()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Emit") :
		emit_on = !emit_on
		if emit_on :
			$Sound_gray.volume_db = 0
		else :
			$Sound_gray.volume_db = -80
	if Input.is_action_pressed("Blue") and global.fragment >= 1 :
		global.B = !global.B
		if global.B :
			$Sound_blue.volume_db = 0
		else :
			$Sound_blue.volume_db = -80
	if Input.is_action_pressed("Green") and global.fragment >= 2 :
		global.G = !global.G
		if global.G :
			$Sound_green.volume_db = 0
		else :
			$Sound_green.volume_db = -80
	if Input.is_action_pressed("Red") and global.fragment >= 3 :
		global.R = !global.R
		if global.R :
			$Sound_red.volume_db = 0
		else :
			$Sound_red.volume_db = -80
	

func _process(delta: float) -> void:
	sprite.modulate.b = 1.0 if global.B else 0.5
	sprite.modulate.g = 1.0 if global.G else 0.5
	sprite.modulate.r = 1.0 if global.R else 0.5
	
	if emit_on and $WaveCool.time_left == 0 :	
		var wave = wave.instantiate() as Node2D
		get_tree().root.add_child(wave)
		wave.launch(global_position)
		$WaveCool.start()
		
func change_arrow() :
	if global.B and global.G and global.R :
		velocity = Vector2(0, 0)
	elif global.B and global.G:
		velocity = Input.get_vector("Up", "Right", "Down", "Left").normalized()
	elif global.G and global.R :
		velocity = Input.get_vector("Up", "Down", "Left", "Right").normalized()
	elif global.B and global.R :
		velocity = Input.get_vector("Left", "Down", "Right", "Up").normalized()
	elif global.B :
		velocity = Input.get_vector("Left", "Right", "Down", "Up").normalized()
	elif global.G :
		velocity = Input.get_vector("Up", "Right", "Left", "Down").normalized()
	elif global.R :
		velocity = Input.get_vector("Left", "Down", "Up", "Right").normalized()
	else :
		velocity = Input.get_vector("Right", "Left", "Up", "Down").normalized()

func die():
	set_physics_process(false)
	set_process(false)
	global.B = false
	global.G = false
	global.R = false

   # Tween 애니메이션 실행
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.1, 0.1), 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_callback(Callable(self, "_on_death_shrink_finished"))

func _on_death_shrink_finished():
	# 부활 위치로 이동 또는 씬 리로드
	if global.respawn_position != Vector2.ZERO:
		global_position = global.respawn_position
		scale = Vector2.ONE
		velocity = Vector2.ZERO
		set_physics_process(true)
		set_process(true)
	else:
		get_tree().reload_current_scene()
