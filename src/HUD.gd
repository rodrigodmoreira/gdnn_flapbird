extends Control

onready var rogerin_counter := $RogerinCounter/CounterPanel/Label
onready var scores_label := $RogerinCounter/ScorePanel/Label
onready var time_label := $RogerinCounter/TimePanel/Label
onready var gen_label := $RogerinCounter/GenPanel/Label

var player_group: Node2D
var player_count := 0
var last_gen_scores := []
var gen_start_time := 0.0
var current_gen := 0

func _ready():
	update_counter_text()
	player_group = get_tree().current_scene.get_node("PlayerGroup")
	gen_start_time = OS.get_ticks_msec()
	_update_Gen_label()

func _format_count_str(num):
	return str("%02d" % player_count)

func _process(delta):
	time_label.text = "TIME: %.2f" % ((OS.get_ticks_msec() - gen_start_time)/1000.0)

func _physics_process(delta):
	update_count()
	update_counter_text()

func update_count():
	if is_instance_valid(player_group):
		player_count = player_group.num_players - player_group.num_deaths

func update_counter_text():
	rogerin_counter.text = _format_count_str(player_count)


func update_Score(scores: Array):
	last_gen_scores = scores
	var score_text = "TOP ROGERIN'S\nLAST GEN SCORE:"
	for i in range(scores.size()):
		score_text += "\n%d - %3.2f" % [i+1, scores[i]]
	scores_label.text = score_text

func reset_Time():
	gen_start_time = OS.get_ticks_msec()

func update_Gen():
	current_gen += 1
	_update_Gen_label()

func _update_Gen_label():
	gen_label.text = "GEN %d" % (current_gen+1)
	
