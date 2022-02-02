extends Node2D

export var num_players := 0
var num_deaths := 0

var spawn: Node2D
var pop := Population.new()
var player_res = preload("res://src/Player.tscn")
var player_pos := Vector2.ZERO


func _ready():
	var net := GANetwork.new()
	net.add_layer(4) # input layer
	net.add_layer(4) # hidden layer
	net.add_layer(1) # output layer: jump input
	net.init()
	
	pop.mutation_rate = .2
	pop.mutation_power = 2 # mutation range multiplier
	pop.crossover_rate = .3
	pop.kill_worse_rate = .2 # remove 20% worse individuals
	pop.keep_best_rate = .1 # keep/don't mutate 10% best individuals
	pop.size = 10 # number of individuals
	pop.init(net)
	pop.randomize() # randomize weights
	
	player_pos = get_viewport_rect().size * Vector2(0.1, 0.4)
	
	spawn = get_tree().current_scene.get_node("Spawn")
	
	create_players()

func create_players():
	var networks = pop.get_networks()
	num_deaths = 0
	num_players = networks.size()
	for net in networks:
		var player = player_res.instance()
		player.net = net
		add_child(player)
		player.position = player_pos + Vector2(0, -20 + randi()%40)
		player.connect("die", self, "_on_Player_death")

func _on_Player_death():
	num_deaths += 1
	if num_deaths == num_players:
		for player in get_children():
			if is_instance_valid(player):
				player.queue_free()
		spawn.stop()
		spawn.start()
		pop.call_deferred("epoch") # generate next generation
		call_deferred("create_players")
