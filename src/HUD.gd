extends Control

onready var rogerin_counter := $RogerinCounter/CounterPanel/Label

var player_group: Node2D
var player_count := 0

func _ready():
	update_counter_text()
	player_group = get_tree().current_scene.get_node("PlayerGroup")

func _format_count_str(num):
	return str("%02d" % player_count)

func _physics_process(delta):
	update_count()
	update_counter_text()

func update_count():
	if is_instance_valid(player_group):
		player_count = player_group.get_child_count()
		print(player_count)

func update_counter_text():
	rogerin_counter.text = _format_count_str(player_count)
