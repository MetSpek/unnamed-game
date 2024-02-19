extends Node
class_name DodgeComponent

@onready var cooldown_timer = $CooldownTimer
@onready var dodge_length_timer = $DodgeLengthTimer
@onready var particles = $Particles

@export var BASE_DODGE_COOLDOWN := 2.0
@export var BASE_DODGE_SPEED := 800
@export var BASE_DODGE_LENGTH := .2
@export var player : CharacterBody2D
@export var player_movement_component : PlayerMovementComponent

var can_dodge = true
var normal_speed : int

func _ready():
	cooldown_timer.wait_time = BASE_DODGE_COOLDOWN
	dodge_length_timer.wait_time = BASE_DODGE_LENGTH

func _physics_process(delta):
	dodge() if Input.is_action_just_pressed("dodge") else null

func dodge():
	if can_dodge:
		# Check if player is standing still
		if player.velocity == Vector2(0,0):
			return
		
		# Keep track of old speed so it resets correctly
		normal_speed = player_movement_component.speed
		
		player_movement_component.speed = BASE_DODGE_SPEED
		
		player_movement_component.can_change_direction = false
		can_dodge = false
		PlayerBool.player_is_dodging = true
		particles.emitting = true
		dodge_length_timer.start()

func _on_dodge_length_timer_timeout():
	player_movement_component.speed = normal_speed
	player_movement_component.can_change_direction = true
	PlayerBool.player_is_dodging = false
	particles.emitting = false
	cooldown_timer.start()

func _on_cooldown_timer_timeout():
	can_dodge = true
