extends KinematicBody2D

const GRAVITY := 16000
const JUMP_SPEED := 0.6 * GRAVITY

var jump := 0.0
var vel := 0.0

var is_dead := false
signal die

func _physics_process(delta):
	var axis := get_input_from_key()
	
	vel += GRAVITY*delta
	if jump > 0.5 or axis.y > 0:
		jump = 0
		vel = -JUMP_SPEED
	
	move_and_slide(
		Vector2(0, vel) * delta,
		Vector2.UP)
	
	if global_position.y < 0 or global_position.y > get_viewport_rect().size.y:
		die()

func get_input_from_key() -> Vector2:
	var axis := Vector2(0,0)
	
	if Input.is_action_just_pressed("jump"):
		axis.y += 1
	
	return axis

func die():
	if !is_dead:
		is_dead = true
		visible = false
		emit_signal("die")
		set_physics_process(false)
