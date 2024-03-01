extends Node2D
class_name IceBall

@onready var sprite = $Sprite
@onready var aoe = $MagicHitboxComponent2/AoE
@onready var trigger = $TriggerHitbox/Trigger
@onready var magic_projectile_component = $MagicProjectileComponent
@onready var magic_disable_component = $MagicDisableComponent
@onready var explosion = $Explosion

var title = "Ice Ball"

func _physics_process(delta):
	sprite.rotation_degrees += 5

func hit():
	explode()

func wall():
	explode()

func explode():
	trigger.set_deferred("disabled", true)
	
	explosion.emitting = true
	
	aoe.set_deferred("disabled", false)
	await get_tree().create_timer(.05).timeout
	aoe.set_deferred("disabled", true)
	
	if magic_disable_component:
		magic_disable_component.disable()
	await get_tree().create_timer(.5).timeout
	queue_free()
	

func _on_trigger_hitbox_area_entered(area):
	explode()

func _on_trigger_hitbox_body_entered(body):
	explode()
