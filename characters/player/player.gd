extends CharacterBody2D

enum States {ALIVE, INVULNERABLE, DEAD}

var _state : int = States.ALIVE

# General stats
@export var base_health = 0
@export var base_speed = 0
@export var base_attack_speed = 0

@export var base_strength : int = 0
@export var base_dexterity : int = 0
@export var base_intelligence : int = 0
@export var base_luck : int = 0

@export var base_dodge_amount : int = 0
@export var base_dodge_cooldown : float = 0
@export var base_dodge_invulnerability : float = 0

var stats

# Animation
@onready var sprite = $Sprite
@onready var animation_player = $AnimationPlayer

# Dodging
@onready var dodge_timer = $Dodge/DodgeTimer
@onready var invulnerable_timer = $Dodge/InvulnerableTimer
var can_dodge = true

# Health
@onready var health = $Health

# Attack
@onready var attack_timer = $Attack/AttackTimer
var can_attack = true

# Inventory
@onready var hand = $Hand
var inventory = []
var item = null
var weapon = null
var current_inventory_index : int = 0

func _ready():
	set_stats()
	set_nodes()
	set_weapon_stats()


# Sets the players statics from the editor
func set_stats():
	stats = {
		"hp" : base_health,
		"spd" : base_speed,
		"atkspd" : base_attack_speed,
		"str" : base_strength,
		"dex" : base_dexterity,
		"int" : base_intelligence,
		"lck" : base_luck,
		"dgam" : base_dodge_amount,
		"dgcd" : base_dodge_cooldown,
		"dginv" : base_dodge_invulnerability
	}

func set_nodes():
	dodge_timer.wait_time = stats.dgcd
	invulnerable_timer.wait_time = stats.dginv

func _physics_process(delta):
	if not _state == States.DEAD:
		move_player()
		animate_player()
		
		dodge() if Input.is_action_just_pressed("dodge") else null
		
		attack() if Input.is_action_pressed("attack") else null
		
		move_inventory("up") if Input.is_action_just_pressed("inventory_up") else move_inventory("down") if Input.is_action_just_pressed("inventory_down") else null
		use_item() if Input.is_action_just_pressed("use") else null

func get_input():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return direction

func move_player():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = get_input()
	if direction:
		velocity = direction * stats.spd
	else:
		velocity.x = move_toward(velocity.x, 0, stats.spd)
		velocity.y = move_toward(velocity.y, 0, stats.spd)
	move_and_slide()

func animate_player():
#	if velocity.x != 0:
#		sprite.flip_h = true if velocity.x > 0 else false

	sprite.flip_h = true if get_local_mouse_position().x > 0 else false
	hand.look_at(get_global_mouse_position())

func dodge():
	if can_dodge:
		if velocity == Vector2(0,0):
			return
		# Increase movement speed and make character invulnerable
		stats.spd = stats.spd * 3
		_state = States.INVULNERABLE
		
		print(velocity.x)
		if sprite.flip_h == true:
			animation_player.play("dodge_right")
		else:
			animation_player.play("dodge_left") 
		
		can_dodge = false
		dodge_timer.start()
		invulnerable_timer.start()

func attack():
#	if can_attack:
#
		if weapon.has_method("attack"):
			weapon.attack()
			
		can_attack = false
		attack_timer.start()
		
#		stats.hp = health.decrease_hp(stats.hp, 10)
#		death() if health.check_death(stats.hp) else null

func death():
	_state = States.DEAD

func move_inventory(direction):
	match direction:
		"up":
			current_inventory_index += 1
			if current_inventory_index > inventory.size() - 1:
				current_inventory_index = 0
		"down":
			current_inventory_index -= 1
			if current_inventory_index < 0:
				current_inventory_index = inventory.size() - 1

func use_item():
	print("Use Item " + str(inventory[current_inventory_index]))

func set_weapon_stats():
	weapon = hand.get_child(0)
	weapon.attack_speed_player = stats.atkspd
	weapon.attack_damage_player = stats.str
#	attack_timer.wait_time = stats.atkspd / weapon.attack_speed

func _on_dodge_timer_timeout():
	can_dodge = true

func _on_invulnerable_timer_timeout():
	# Returns the values to normal
	stats.spd = stats.spd / 3
	_state = States.ALIVE

func _on_attack_timer_timeout():
	can_attack = true
