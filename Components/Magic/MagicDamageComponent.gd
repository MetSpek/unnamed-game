extends Node
class_name MagicDamageComponent

@export var BASE_DAMAGE := 1

var damage : int

func _ready():
	damage = BASE_DAMAGE
