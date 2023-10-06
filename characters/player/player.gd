extends CharacterBody2D

# General stats
@export var base_health = 0
@export var base_speed = 0
@export var base_attack_speed = 0

@export var base_strength = 0
@export var base_dexterity = 0
@export var base_intelligence = 0
@export var base_luck = 0

@export var base_dodge_amount = 0
@export var base_dodge_cooldown = 0
@export var base_dodge_invulnerability = 0

var stats

func _ready():
	set_stats()
	print(stats)

# Sets the players statics from the editor
func set_stats():
	stats = {
		"hp" : base_health,
		"spd" : base_speed,
		"atkspd" : base_attack_speed,
		"str" : base_strength,
		"dex" : base_dexterity,
		"int" : base_intelligence,
		"lck" : base_luck,
		"dgam" : base_dodge_amount,
		"dgcd" : base_dodge_cooldown,
		"dginv" : base_dodge_invulnerability
	}
