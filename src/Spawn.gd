extends Node2D

export var spawn_time = 1.5

onready var timer = $Timer
var obstacle_res = preload("res://src/Obstacle.tscn")
var obstacles = []

signal pass_obstacle

func _ready():
	timer.wait_time = spawn_time

func stop():
	for o in obstacles:
		if is_instance_valid(o):
			o.queue_free()
	timer.stop()
	obstacles = []

func start():
	timer.start()
	_on_Timer_timeout()

func _on_Timer_timeout():
	var obstacle = obstacle_res.instance()
	add_child(obstacle)
	obstacle.global_position.x = get_viewport_rect().size.x + 50
	obstacles.append(obstacle)
	obstacle.connect("deactive", self, "_on_Tube_deactive")

func get_pos_info():
	if len(obstacles) == 0:
		return [0,0,0]
	return obstacles[0].get_pos_info()


func _on_Tube_deactive():
	obstacles.pop_front()
	emit_signal("pass_obstacle")
