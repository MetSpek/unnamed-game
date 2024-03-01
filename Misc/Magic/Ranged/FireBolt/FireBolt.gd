extends Node2D
class_name FireBolt

@onready var magic_disable_component = $MagicDisableComponent
@onready var animation_player = $AnimationPlayer

var title = "Fire Bolt"

func hit():
	remove()

func wall():
	remove()

func remove():
	if magic_disable_component:
		magic_disable_component.disable()
	animation_player.play("Explosion")
	await get_tree().create_timer(.5).timeout
	queue_free()
