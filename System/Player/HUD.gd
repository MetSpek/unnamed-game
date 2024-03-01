extends CanvasLayer
class_name HUD
# Stats
@onready var health = $Container/Stats/StatsHBoxContainer/Health
@onready var mana = $Container/Stats/StatsHBoxContainer/Mana

# Deck
@onready var card = $Container/Deck/Card

@export var health_component : HealthComponent
@export var magic_component : MagicComponent

func _process(delta):
	if health_component:
		health.text = "Health: " + str(health_component.health)
	
	if magic_component:
		mana.text = "Mana: " + str(round(magic_component.mana))
		card.text = "Next card: " + str(magic_component.hand[0].name)
