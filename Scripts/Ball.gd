extends RigidBody2D 

onready var Game = get_node("/root/Game")
onready var Starting = get_node("/root/Game/Starting")
export var speed = 800
var vel = Vector2()

func _ready():
	contact_monitor = true
	set_max_contacts_reported(4)

func change_game():
	if len(get_tree().get_nodes_in_group("Tiles")) < 20:
		Starting.startCountdown(3)
		queue_free()

func _physics_process(delta):
	# Check for collisions
	if len(get_tree().get_nodes_in_group("Tiles")) < 20:
		set_position(get_position_in_parent() + vel * delta)
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("Tiles"):
			Game.change_score(body.points)
			body.queue_free()
	
	if position.y > get_viewport().size.y:
		Game.change_lives(-1)
		Starting.startCountdown(3)
		queue_free()