extends Node
class_name AttackComponent

@export var weapon : Weapon

func _ready():
	print(weapon)

func _physics_process(delta):
	secondaryAttack() if Input.is_action_pressed("secondary_attack") else null
	releaseSecondaryAttack() if Input.is_action_just_released("secondary_attack") else null
	
	primaryAttack() if Input.is_action_pressed("primary_attack") else null
	releasePrimaryAttack() if Input.is_action_just_released("primary_attack") else null

func primaryAttack():
	if weapon:
		if weapon.has_method("primaryAttack"): 
			weapon.primaryAttack()

func releasePrimaryAttack():
	if weapon:
		if weapon.has_method("releasePrimaryAttack"):
			weapon.releasePrimaryAttack()

func secondaryAttack():
	if weapon:
		if weapon.has_method("secondaryAttack"): 
			weapon.secondaryAttack()

func releaseSecondaryAttack():
	if weapon:
		if weapon.has_method("releaseSecondaryAttack"):
			weapon.releaseSecondaryAttack()
