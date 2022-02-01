extends Node2D

onready var spawn := $Spawn
onready var player_group := $PlayerGroup

var player_res := preload("res://src/Player.tscn")
var players = []

func _ready():
	_on_Player_death()

func _on_Player_death():
	spawn.stop()
	kill_players()
	create_players()
	spawn.start()

func kill_players():
	for p in player_group.get_children():
		p.queue_free()

func create_players():
	for ip in range(10):
		var p = player_res.instance()
		var viewport_size = get_viewport_rect().size
		p.position = viewport_size * Vector2(0.1, 0.4) + Vector2(-15 + randi()%30, -20 + randi()%40)
		player_group.add_child(p)
		p.connect("die", self, "_on_Player_death")
		players.append(p)
