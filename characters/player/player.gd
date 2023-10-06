extends CharacterBody2D

enum States {ALIVE}

var _state : int = States.ALIVE

# General stats
@export var base_health = 0
@export var base_speed = 0
@export var base_attack_speed = 0

@export var base_strength = 0
@export var base_dexterity = 0
@export var base_intelligence = 0
@export var base_luck = 0

@export var base_dodge_amount = 0
@export var base_dodge_cooldown = 0
@export var base_dodge_invulnerability = 0

var stats

func _ready():
	set_stats()

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

func _physics_process(delta):
	move_player()

func move_player():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * stats.spd
	else:
		velocity.x = move_toward(velocity.x, 0, stats.spd)
		velocity.y = move_toward(velocity.y, 0, stats.spd)

	move_and_slide()
