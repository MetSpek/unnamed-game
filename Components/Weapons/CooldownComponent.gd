extends Timer
class_name CooldownComponent

@export var weapon : Weapon
@export var BASE_COOLDOWN := 1.0

enum OptionType {
	PRIMARY,
	SECONDARY
}

# Export the enum as a property
@export var selectedOption : OptionType = OptionType.PRIMARY


func _ready():
	wait_time = BASE_COOLDOWN

func startCooldown(type):
	if type == OptionType.keys()[selectedOption].to_lower():
		start()

func _on_timeout():
	if selectedOption == OptionType.PRIMARY:
		weapon.can_attack = true
	elif selectedOption == OptionType.SECONDARY:
		weapon.can_secondary_attack = true
