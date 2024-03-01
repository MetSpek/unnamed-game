extends CharacterBody2D
class_name Slime

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite
@onready var collision = $HitboxComponent/Collision

@export var possible_colours : Array[Color]
@export var damage := 10
@export var attack_speed = 1.0

var is_alive = true
var in_attack_range = false
var can_attack = true

func _ready():
	var colour = possible_colours[randi_range(0, possible_colours.size() - 1)]
	sprite.modulate = colour

func _physics_process(delta):
	if is_alive:
		move_and_slide()
		animateSlime()
	
		if in_attack_range and can_attack :
			attack()

func animateSlime():
	if velocity.length() > 0:
		animation_player.play("Walking")
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

func attack():
	can_attack = false
	animation_player.play("Attack")
	await get_tree().create_timer(attack_speed).timeout
	can_attack = true

func damage_target():
	get_tree().call_group("PlayerHealth", "decreaseHp", damage)

func got_damaged():
	pass

func die():
	velocity = Vector2.ZERO
	is_alive = false
	collision.set_deferred("disabled", true)
	animation_player.current_animation
	sprite.play("Dead")
	await get_tree().create_timer(1).timeout
	animation_player.play("Die")
