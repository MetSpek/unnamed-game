extends Node2D
class_name Card

@onready var background = $Background
@onready var title_label = $TitleLabel
@onready var mana_label = $ManaLabel
@onready var animation_player = $AnimationPlayer

var magic

func _ready():
	if magic:
		title_label.text = magic.title
		mana_label.text = str(magic.find_child("MagicManaComponent").BASE_MANA_COST)

func useCard():
	animation_player.play("Use")

func remove():
	queue_free()
