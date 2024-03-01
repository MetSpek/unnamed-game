extends Area2D
class_name MagicHitboxComponent

@export var magic_weapon = Node
@export var magic_damage_component : MagicDamageComponent

func _on_area_entered(area):
	if area.has_method("damage") and magic_damage_component.damage > 0:
		area.damage(magic_damage_component.damage)
		
	magic_weapon.hit()


func _on_body_entered(body):
	magic_weapon.wall()
