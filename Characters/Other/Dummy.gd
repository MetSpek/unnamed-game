extends CharacterBody2D
class_name Dummy

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Pivot/Sprite

func got_damaged():
	animation_player.stop()
	animation_player.play("get_damaged")
