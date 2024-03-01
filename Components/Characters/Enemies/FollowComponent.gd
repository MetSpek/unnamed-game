extends NavigationAgent2D
class_name FollowComponent

@onready var los = $LoS

@export var enemy : CharacterBody2D
@export var follow_speed := 100
@export var min_range := 50
@export var max_range := 600
@export var avoid_distance := 10

var player : CharacterBody2D
var intended_velocity
var dir : Vector2
var distance

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	radius = avoid_distance
	max_speed = follow_speed

func _physics_process(_delta):
	if player:
		distance = player.global_position - enemy.global_position
		move_enemy()
		if distance.length() < min_range and hasLos():
			enemy.can_move = false
			enemy.in_attack_range = true
		if distance.length() > min_range * 2:
			enemy.in_attack_range = false
			enemy.can_move = true

func move_enemy():
	if distance.length() > min_range and distance.length() < max_range:
		if hasLos():
			if enemy.status == "searching" or enemy.status == "idle":
				enemy.status = "following"
		else:
			if enemy.status == "following":
				enemy.status = "searching"
	else:
		if enemy.status == "following":
			enemy.status = "searching"
	
	dir = (get_next_path_position() - enemy.global_position).normalized()
	velocity = dir * follow_speed

func _on_velocity_computed(safe_velocity):
	if enemy.can_move and enemy.is_alive:
		enemy.velocity = safe_velocity
		enemy.move_and_slide()
	else:
		enemy.velocity = Vector2.ZERO

func _on_recalculate_timer_timeout():
	if enemy.status == "following":
		target_position = player.global_position

func _on_navigation_finished():
	if enemy.status == "searching":
		enemy.status = "idle"

func hasLos():
	if los:
		los.position = enemy.global_position
		los.target_position = player.global_position - los.position
		return !los.is_colliding()
