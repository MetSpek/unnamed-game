extends CanvasLayer

@onready var health_label = $Container/VBoxContainer/HealthLabel
@onready var speed_label = $Container/VBoxContainer/SpeedLabel
@onready var can_dodge_label = $Container/VBoxContainer/CanDodgeLabel
@onready var can_attack_label = $Container/VBoxContainer/CanAttackLabel

@export var player : Player
@export var health : HealthComponent
@export var movement : PlayerMovementComponent
@export var dodge : DodgeComponent
@export var weapon : Weapon


var nodes : Array

func _ready():
	nodes = [player, health, movement, dodge, weapon]

func _process(delta):
	for node in nodes:
		if is_instance_valid(node):
			match node.name:
				"HealthComponent":
					health_label.text = "Health: " + str(health.health)
				"PlayerMovementComponent":
					speed_label.text = "Speed: " + str(player.velocity)
				"DodgeComponent":
					can_dodge_label.text = "Can Dodge: " + str(dodge.can_dodge)
				"Weapon", "ShortSword":
					can_attack_label.text = "Can Attack: " + str(weapon.can_attack)
				_:
					pass
