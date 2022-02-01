extends Node2D

onready var upperBooks := $UpperBooks
onready var lowerBooks := $LowerBooks

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
