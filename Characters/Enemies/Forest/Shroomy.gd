extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite
@onready var charge_raycast = $Attack/ChargeRaycast
@onready var attack_duration = $Attack/AttackDuration
@onready var true_los = $Attack/TrueLoS

@export var jump_speed := 100
@export var jump_duration := 1.0
@export var damage := 25

var is_alive = true
var status = "idle"
var can_move = true
var in_attack_range = false
var can_attack = true
var player : CharacterBody2D
var looking_at_player = false

var jump_dir
var speed

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	attack_duration.wait_time = jump_duration

func _physics_process(_delta):
	if is_alive:
		animate()
		true_los.target_position = player.global_position - global_position
		if in_attack_range and can_attack :
			attack()
		if status == "attacking":
			speed = jump_dir * jump_speed
			velocity = speed
			move_and_slide()
				
		if status == "falling":
			# Slowly decrease speed
			var speed_tween = get_tree().create_tween()
			speed_tween.tween_property(self, "speed", Vector2.ZERO, .3)
			velocity = speed
			move_and_slide()
			
			# Done slowing down
			if velocity.length() < 20:
				charge_raycast.enabled = false
				status = "following"
				await get_tree().create_timer(1).timeout
				can_move = true
				can_attack = true
		
		if charge_raycast.is_colliding() and is_alive:
			if charge_raycast.get_collider().name == "Player":
				get_tree().call_group("PlayerHealth", "decreaseHp", damage)
				die()
			else:
				die()

func attack():
	if not true_los.is_colliding():
		can_attack = false
		can_move = false
		looking_at_player = true
		animation_player.play("Attack")
		status = "charging"
		
		# Charge attack
		await get_tree().create_timer(1).timeout
		if not true_los.is_colliding():
			status = "attacking"
			looking_at_player = false
			jump_dir = global_position.direction_to(player.global_position - Vector2(0,-10))
			charge_raycast.rotation = jump_dir.angle()
			charge_raycast.enabled = true
			attack_duration.start()
		else:
			status = "following"
			can_move = true
			can_attack = true

func die():
	is_alive = false

func animate():
	if velocity.length() > 0:
		animation_player.play("Walking")
	if looking_at_player:
		if global_position.x - player.global_position.x > 0:
			sprite.flip_h = false
		elif global_position.x - player.global_position.x < 0:
			sprite.flip_h = true
	else:
		if velocity.x > 0:
			sprite.flip_h = true
		elif velocity.x < 0:
			sprite.flip_h = false

func _on_attack_duration_timeout():
	if is_alive:
		status = "falling"
	
