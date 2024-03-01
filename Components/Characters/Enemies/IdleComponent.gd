extends Node2D

@onready var timer = $Timer
@onready var ray_cast_2d : RayCast2D = $RayCast2D 

@export var enemy : CharacterBody2D
@export var move_time := 1.0
@export var wait_time := 1.0
@export var idle_speed := 100
@export var rotation_speed := 5

var is_moving = true
var dir
var rotation_rate
var is_rotating = false

func _ready():
	timer.wait_time = move_time
	ray_cast_2d.enabled = false

func _physics_process(_delta):
	if enemy:
		if enemy.status == "idle":
			if not is_moving:
				getRandomDirection()
				is_moving = true
				timer.start()
				ray_cast_2d.rotation = dir.angle()
				ray_cast_2d.enabled = true
			else:
				if dir:
					enemy.velocity = dir * idle_speed
					if enemy.has_method("animate"):
						enemy.animate()
					enemy.move_and_slide()
					
					if ray_cast_2d.is_colliding() and not is_rotating:
						is_rotating = true
						
					if is_rotating:
						rotation_rate = deg_to_rad(rotation_speed) 
						var tween = create_tween()
						tween.tween_property(self, "dir", dir.rotated(deg_to_rad(90)), 0.5)
						is_rotating = false
					ray_cast_2d.rotation = dir.angle()

func getRandomDirection():
	dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))

func _on_timer_timeout():
	dir = Vector2.ZERO
	ray_cast_2d.enabled = false
	await get_tree().create_timer(randf_range(wait_time - 2, wait_time + 2)).timeout
	is_moving = false
	
