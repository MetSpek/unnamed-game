extends Node
class_name MagicDisableComponent

@export var magic_projectile_component : MagicProjectileComponent
@export var magic_particle_component : MagicParticleComponent
@export var sprite : Sprite2D
@export var magic_hitbox_component : MagicHitboxComponent

func disable():
	if magic_projectile_component:
		magic_projectile_component.can_move = false

	if magic_particle_component:
		magic_particle_component.emitting = false

	if sprite:
		sprite.visible = false
	
	if magic_hitbox_component:
		if magic_hitbox_component.get_child(0):
			magic_hitbox_component.get_child(0).set_deferred("disabled", true)
