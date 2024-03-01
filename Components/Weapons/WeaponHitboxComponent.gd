extends Area2D
class_name WeaponHitboxComponent

@export var weapon : Weapon

func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage(weapon.damage)
