extends Node2D
class_name FollowComponent

@export var enemy : CharacterBody2D
@export var follow_speed := 100
@export var min_range := 50
@export var max_range := 600

var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	var direction = player.global_position - enemy.global_position
	if direction.length() > min_range and direction.length() < max_range:
		enemy.velocity = direction.normalized() * follow_speed
	else:
		enemy.velocity = Vector2()

	if direction.length() < min_range:
		enemy.in_attack_range = true
	else:
		enemy.in_attack_range = false
