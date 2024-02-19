extends Node2D
class_name Weapon

@onready var animation_player = $AnimationPlayer
@onready var sprite = $WeaponVisuals/Sprite

@export var weapon_hitbox_component : WeaponHitboxComponent
@export var BASE_DAMAGE := 0

@export var BASE_MAX_CHARGED_DAMAGE := 0
@export var BASE_CHARGE_DURATION := 1.5
@export var BASE_CHARGE_SIZE := 1.5
@export var BASE_MINIMUM_CHARGE_SIZE := 1.2

@export var BASE_MOVEMENT_REDUCTION := .5
@export var BASE_CHARGE_MOVEMENT_REDUCTION := .2

var can_attack := true
var can_secondary_attack := true
var is_charging := false
var charge := 1.0
var damage
var charge_damage

var size_tween
var damage_tween

func _ready():
	damage = BASE_DAMAGE

func primaryAttack():
	if can_attack and not is_charging and not PlayerBool.player_is_dodging:
		get_tree().call_group("CooldownComponent", "startCooldown", "primary")
		PlayerStats.weapon_movement_modifier = BASE_MOVEMENT_REDUCTION
		can_attack = false
		animation_player.stop()
		animation_player.play("PrimaryAttack")
	elif PlayerBool.player_is_dodging:
		PlayerStats.weapon_movement_modifier = 1

func releasePrimaryAttack():
	if not is_charging:
		PlayerStats.weapon_movement_modifier = 1

func secondaryAttack():
	if not PlayerBool.player_is_dodging and can_secondary_attack and can_attack and not is_charging:
		can_attack = false
		is_charging = true
		var size_tween = create_tween()
		var damage_tween = create_tween()
		charge_damage = BASE_DAMAGE
		size_tween.tween_property(weapon_hitbox_component, "scale", Vector2(BASE_CHARGE_SIZE,BASE_CHARGE_SIZE), BASE_CHARGE_DURATION)
		damage_tween.tween_property(self, "charge_damage", BASE_MAX_CHARGED_DAMAGE, BASE_CHARGE_DURATION)
		PlayerStats.weapon_movement_modifier = BASE_CHARGE_MOVEMENT_REDUCTION
		animation_player.stop()
		animation_player.speed_scale = 1 / BASE_CHARGE_DURATION
		animation_player.play("SecondaryCharge")

func releaseSecondaryAttack():
	if is_charging:
		
		if size_tween and damage_tween:
			size_tween.kill(self)
			damage_tween.kill(self)
			
		animation_player.speed_scale = 1
		get_tree().call_group("CooldownComponent", "startCooldown", "primary")
		if weapon_hitbox_component.scale.x > BASE_MINIMUM_CHARGE_SIZE:
			damage = charge_damage
			print("deal damage for: " + str(damage))
			animation_player.play("SecondaryAttack")
			can_secondary_attack = false
			get_tree().call_group("CooldownComponent", "startCooldown", "secondary")
		else:
			resetStats()
		is_charging = false

func resetStats():
	charge = 1.0
	damage = BASE_DAMAGE
	weapon_hitbox_component.scale = Vector2(1, 1)
	animation_player.stop()
	sprite.modulate = "#FFFFFF"
	PlayerStats.weapon_movement_modifier = 1
	
