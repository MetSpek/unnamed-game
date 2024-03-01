extends Node2D

@export var attack_speed : float = 1.0
@export var attack_delay : float = 1.0
@export var base_damage : int = 1

var attack_damage_player : int
var can_attack = true
var attack_speed_player : float

var current_attack = 1
var attack_pattern_amount : int

@onready var attack_delay_timer = $HitBox/AttackDelayTimer
@onready var attack_duration_timer = $HitBox/AttackDurationTimer
@onready var collision = $HitBox/Collision
@onready var animation_player = $AnimationPlayer

func _ready():
	attack_delay_timer.wait_time = attack_delay
	attack_pattern_amount = animation_player.get_animation_list().size() - 1

func attack():
	if not animation_player.is_playing() and can_attack:
		can_attack = false
		collision.disabled = false
		
		play_animation()
		
		attack_duration_timer.wait_time = animation_player.current_animation_length
		attack_delay_timer.wait_time = animation_player.current_animation_length * 2
		
		current_attack += 1
		if current_attack > attack_pattern_amount:
			current_attack = 1
			attack_delay_timer.wait_time = animation_player.current_animation_length * 4
		
		attack_duration_timer.start()
		attack_delay_timer.start()

func play_animation():
	animation_player.speed_scale = attack_speed * attack_speed_player

	var animation = "attack_" + str(current_attack)
	print(animation)
	animation_player.play(animation)


func _on_attack_duration_timer_timeout():
	collision.disabled = true


func _on_attack_delay_timer_timeout():
	can_attack = true


func _on_hit_box_area_entered(area):
	if area.has_method("hit"):
		area.hit(base_damage * attack_damage_player)
