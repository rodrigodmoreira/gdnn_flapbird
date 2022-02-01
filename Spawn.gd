extends Node2D

export var spawn_time = 1.5

onready var timer = $Timer
var obstacle_res = preload("res://src/Obstacle.tscn")
var obstacles = []

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
	obstacle.global_position.x = get_viewport_rect().size.x + 50
	add_child(obstacle)
	obstacles.append(obstacle)
