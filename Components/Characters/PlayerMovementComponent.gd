extends Node
class_name PlayerMovementComponent

@export var BASE_MOVEMENT_SPEED := 300
@export var player : CharacterBody2D

var speed : int
var direction : Vector2
var can_change_direction := true

var debug_speed : int

func _ready():
	speed = BASE_MOVEMENT_SPEED

func _physics_process(delta):
	move_player()

func get_input():
	if can_change_direction:
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return direction

func move_player():
	var direction = get_input()
	
	debug_speed = speed * PlayerStats.weapon_movement_modifier
	
	if direction:
		player.velocity = direction * (speed * PlayerStats.weapon_movement_modifier)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.velocity.y = move_toward(player.velocity.y, 0, speed)
	player.move_and_slide()

func modifySpeed(modifier):
	speed = speed * modifier
