extends Control
class_name  Bar

@onready var health_bar = $HealthBar
@onready var health_label = $HealthBar/HealthLabel

@onready var mana_bar = $ManaBar
@onready var mana_label = $ManaBar/ManaLabel

@export var HUD : HUD

func _ready():
	if HUD:
		await get_tree().create_timer(.01).timeout
		health_bar.max_value = HUD.health_component.health
		setHealthBar()
		
		mana_bar.max_value = HUD.magic_component.mana
		setManaBar()

func _process(delta):
	if HUD:
		setHealthBar()
		setManaBar()

func setHealthBar():
	health_bar.value = HUD.health_component.health
	health_label.text = "   " + str(HUD.health_component.health)

func setManaBar():
	mana_bar.value = HUD.magic_component.mana
	mana_label.text = "   " + str(int(HUD.magic_component.mana))
	
