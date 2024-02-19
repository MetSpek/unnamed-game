extends Area2D
class_name ProjectileHomingComponent

@onready var range = $CollisionShape2D
@onready var los_raycast = $LosRaycast
@onready var activation_timer = $ActivationTimer

@export var magic_projectile_component : MagicProjectileComponent
@export var activation_time := .2
var activated := false

func _ready():
	activation_timer.wait_time = activation_time
	activation_timer.start()

func _physics_process(delta):
	var enemies_in_range = get_overlapping_areas()
	var closest_enemy
	for enemy in enemies_in_range:
		magic_projectile_component.is_homing = true
		var raycast = RayCast2D.new()
		raycast.target_position = enemy.global_position
		if not closest_enemy and not raycast.is_colliding():
				closest_enemy = enemy
		else:
			if global_position.distance_squared_to(enemy.global_position) < global_position.distance_squared_to(closest_enemy.global_position) and not raycast.is_colliding():
				closest_enemy = enemy
	if magic_projectile_component and enemies_in_range.size() > 0 and activated:
		magic_projectile_component.enemy_position = closest_enemy.global_position

	if enemies_in_range.size() == 0:
		magic_projectile_component.is_homing = false

func _on_activation_timer_timeout():
	activated = true
