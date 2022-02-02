extends KinematicBody2D

const GRAVITY := 16000
const JUMP_SPEED := 0.6 * GRAVITY

var net # Typing went wrong

var vel := 0.0
var next_obstacle_pos_info = [0,0,0]

var is_dead := false
signal die

func _physics_process(delta):
	var y_axis := get_input_from_net()
	
	vel += GRAVITY*delta
	if y_axis > 0:
		vel = -JUMP_SPEED
	
	move_and_slide(
		Vector2(0, vel) * delta,
		Vector2.UP)
	
	if global_position.y < 0 or global_position.y > get_viewport_rect().size.y:
		die()

func get_input_from_net() -> float:
	if is_instance_valid(net):
		var input = next_obstacle_pos_info.duplicate()
		input.append(global_position.y)
		
		var viewport_size := get_viewport_rect().size
		input[0] /= viewport_size.x/2
		input[1] /= viewport_size.y/2
		input[2] /= viewport_size.y/2
		input[3] /= viewport_size.y/2
		var out = net.feedforward(input)
		
		return out[0]
	return -1.0

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
