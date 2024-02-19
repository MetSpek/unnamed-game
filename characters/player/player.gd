extends CharacterBody2D
class_name Player

@onready var hand = $Body/Hand
@onready var body = $Body
@onready var animation_player = $Body/AnimationPlayer
@onready var eyes = $Body/Eyes

var mouse_pos
var mouse_position_threshold := 10

func _ready():
	eyes.play("default")

func _physics_process(delta):
	animate_player()
	hand.look_at(get_global_mouse_position())

func animate_player():
	if not velocity == Vector2.ZERO:
		animation_player.speed_scale = 1.5 * PlayerStats.weapon_movement_modifier
		if animation_player.current_animation == "Standing" or not animation_player.is_playing():
			animation_player.play("Walking")
	else:
		if animation_player.current_animation == "Walking" or not animation_player.is_playing():
			animation_player.play("Standing")
	
	# Flip sprite based on current mouse position
	mouse_pos = get_local_mouse_position()
	if mouse_pos.x > mouse_position_threshold:
		body.scale.x = 1
	elif mouse_pos.x < -mouse_position_threshold:
		body.scale.x = -1

func die():
	get_tree().reload_current_scene()
