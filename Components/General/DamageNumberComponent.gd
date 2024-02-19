extends Node2D
class_name DamageNumbercomponent

var label = load("res://Components/General/DamageNumber.tscn")

func makeDamageNumber(damage):
	var damage_label = label.instantiate()
	damage_label.damage = damage
	damage_label.position = global_position
	get_tree().root.add_child(damage_label)
