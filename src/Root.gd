extends Node2D

onready var player_group := $PlayerGroup
onready var spawn := $Spawn

func _physics_process(delta: float) -> void:
	for player in player_group.get_children():
		if is_instance_valid(player):
			player.next_obstacle_pos_info = spawn.get_pos_info()


