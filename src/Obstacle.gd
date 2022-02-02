extends Node2D

onready var upperBooks := $UpperBooks
onready var lowerBooks := $LowerBooks
onready var upperCollisionShape := $UpperBooks/Area2D/CollisionShape2D
onready var lowerCollisionShape := $LowerBooks/Area2D/CollisionShape2D

onready var upperPosition := $UpperBooks/Position
onready var lowerPosition := $LowerBooks/Position

export var speed := 160
export var gap := 150
var is_deactivated = false

signal deactive

func _ready():
	randomize()
	upperBooks.position.y -= gap/2
	lowerBooks.position.y += gap/2
	
	position.y = rand_range(gap/2, get_viewport_rect().size.y - gap/2)

func _physics_process(delta):
	position.x -= speed*delta
	
	if global_position.x < get_viewport_rect().size.x * 0.1 and not is_deactivated:
		is_deactivated = true
		upperCollisionShape.disabled = true
		lowerCollisionShape.disabled = true
		emit_signal("deactive")
	
	if global_position.x < -50:
		queue_free()

func get_pos_info():
	var info = []
	info.append(upperPosition.global_position.x)
	info.append(upperPosition.global_position.y)
	info.append(lowerPosition.global_position.y)
	return info
