extends Node2D

@onready var sprite = $Sprite2D

func _process(delta: float) -> void:
	scale += Vector2(12, 12)*delta
	sprite.modulate.a -= delta
	
func launch(origin : Vector2):
	global_position = origin
	if global.B : 
		sprite.modulate.b = 1
	else :
		sprite.modulate.b = 0.3
	if global.G :
		sprite.modulate.g = 1
	else :
		sprite.modulate.g = 0.3
	if global.R :
		sprite.modulate.r = 1
	else :
		sprite.modulate.r = 0.3

func _on_vanish_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body):
	if (body.is_in_group("wall") or 
		body.is_in_group("water")  or
		body.is_in_group("vine")  or
		body.is_in_group("flame")  or
		(body.is_in_group("saw") and !global.B and global.G and global.R) or
		(body.is_in_group("white") and global.B and global.G and global.R)) :
		body.set_alpha($Sprite2D.modulate.a)
		
func _on_area_entered(area):		
	if ((area.is_in_group("ice") and global.B and global.G and !global.R) or
		(area.is_in_group("laser") and global.B and !global.G and global.R)) :
		area.set_alpha($Sprite2D.modulate.a)
		
