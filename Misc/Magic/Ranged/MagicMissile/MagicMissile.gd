extends Node2D

@onready var magic_disable_component = $MagicDisableComponent

func hit():
	remove()

func wall():
	remove()

func remove():
	if magic_disable_component:
		magic_disable_component.disable()
	await get_tree().create_timer(.5).timeout
	queue_free()
