extends Node
class_name MagicProjectileComponent

@export var magic_weapon = Node
@export var BASE_SPEED := 100
var can_move := true

@export var is_homing := false
var enemy_position : Vector2

var speed : int
var velocity

func _ready():
	speed = BASE_SPEED

func _physics_process(delta):
	if is_homing: 
		move_homing(delta)
	else:
		move_forward(delta)
		

func move_forward(delta):
	if can_move:
		velocity = magic_weapon.transform.x * speed
		magic_weapon.position += velocity * delta

func move_homing(delta):
	if can_move:
		if enemy_position:
			var current_vel = velocity
			var desired_vel = magic_weapon.position.direction_to(enemy_position) * speed
			var change = (desired_vel - current_vel) * 0.05
			
			velocity += change
			magic_weapon.position += velocity * delta
			magic_weapon.look_at(enemy_position)
		else:
			move_forward(delta)
