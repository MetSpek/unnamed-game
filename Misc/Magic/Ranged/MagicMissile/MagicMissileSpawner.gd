extends Node2D
class_name MagicMissile

var missile_prefab = load("res://Misc/Magic/Ranged/MagicMissile/MagicMissile.tscn")

@export var BASE_AMOUNT := 4

var title = "Magic Missile"

func _ready():
	for amount in BASE_AMOUNT:
		var missile = missile_prefab.instantiate()
		missile.position = global_position
		missile.rotation = rotation
		get_tree().root.add_child(missile)
		await get_tree().create_timer(.1).timeout
