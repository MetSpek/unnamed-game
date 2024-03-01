extends CharacterBody2D
class_name Slime

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite
@onready var collision = $HitboxComponent/Collision
@onready var follow_component = $FollowComponent

@export var possible_colours : Array[Color]
@export var damage := 10
@export var attack_speed = 1.0

var is_alive = true
var status = "idle"
var can_move = true
var in_attack_range = false
var can_attack = true
var player : CharacterBody2D

func _ready():
	var colour = possible_colours[randi_range(0, possible_colours.size() - 1)]
	player = get_tree().get_first_node_in_group("Player")
	sprite.modulate = colour

func _physics_process(delta):
	if is_alive:
		animate()

		if in_attack_range and can_attack :
			attack()

func animate():
	if velocity.length() > 0:
		#await get_tree().create_timer(randf_range(0,0.5)).timeout
		animation_player.play("Walking")
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

func attack():
	can_move = false
	can_attack = false
	animation_player.stop()
	animation_player.play("Attack")
	await get_tree().create_timer(attack_speed).timeout
	can_attack = true

func damage_target():
	get_tree().call_group("PlayerHealth", "decreaseHp", damage)

func got_damaged():
	if is_alive:
		status = "attacked"
		if follow_component:
			follow_component.target_position = player.global_position

func die():
	is_alive = false
	follow_component.queue_free()
	collision.set_deferred("disabled", true)
	animation_player.current_animation
	sprite.play("Dead")
	await get_tree().create_timer(1).timeout
	animation_player.play("Die")

func remove_entity():
	queue_free()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		can_move = true
