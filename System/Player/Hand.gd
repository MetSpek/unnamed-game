extends Control

const CARD = preload("res://System/Player/Card.tscn")

func createCard(magic):
	var card = CARD.instantiate()
	card.magic = magic
	add_child(card)
	move_child(card, 0)
	positionChildren()

func removeCard():
	get_child(1).useCard()

func positionChildren():
	if get_child_count() > 1:
		get_child(0).position = Vector2(10,5)
		get_child(0).modulate =  "#555555"
		
		var pos_tween = create_tween()
		var color_tween = create_tween()
		pos_tween.tween_property(get_child(1), "position", Vector2.ZERO, 0.3)
		color_tween.tween_property(get_child(1), "modulate", Color("#ffffff"), 0.3)
		
