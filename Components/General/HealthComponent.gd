extends Node
class_name HealthComponent

@export var BASE_HEALTH := 100

var object
var health

func _ready():
	object = get_parent()
	health = BASE_HEALTH

func decreaseHp(damage):
	health -= damage
	if health <= 0:
		if object.has_method("die"):
			object.die()
