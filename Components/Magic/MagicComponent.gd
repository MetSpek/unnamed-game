extends Node2D
class_name MagicComponent

@onready var recharge_rate_timer = $RechargeRateTimer

@export var BASE_MANA := 100
@export var RECHARGE_RATE := 0.1
@export var RECHARGE_COOLDOWN := 1
var mana : float

var is_recharging := false

var deck := Array()
var hand := Array()

func _ready():
	mana = BASE_MANA
	deck = Deck.deck
	recharge_rate_timer.wait_time = RECHARGE_COOLDOWN
	hand.append(getRandomCard())
	hand.append(getRandomCard())

func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("use"):
		await useMagic()
	
	if is_recharging:
		mana += RECHARGE_RATE
		mana = clamp(mana, 0, BASE_MANA)

func useMagic():
	var magic = hand[0]
	var mana_component = magic.find_child("MagicManaComponent")
	if mana_component:
		if mana >= mana_component.BASE_MANA_COST:
			# Stop recharging 
			if is_recharging:
				recharge_rate_timer.stop()
				is_recharging = false
			
			# Magic stuffs
			if magic.name in ["MagicMissile"]:
				magic.position = position
				magic.transform = transform
				add_child(magic)
			else:
				magic.position = global_position
				magic.transform = global_transform
				get_tree().root.add_child(magic)
			mana -= mana_component.BASE_MANA_COST
			
			# Remove and get new card
			hand.remove_at(0)
			get_tree().call_group("HUDHand", "removeCard")
			hand.append(getRandomCard())
			
			# Start Timer to recharge mana
			recharge_rate_timer.start()

func getRandomCard():
	var card = load(deck[randi() % deck.size()].scene).instantiate()
	var magic_name = deck[randi() % deck.size()].name
	get_tree().call_group("HUDHand", "createCard", card, magic_name)
	return card


func _on_recharge_rate_timer_timeout():
	is_recharging = true
