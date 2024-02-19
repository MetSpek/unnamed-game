extends Area2D

var object
@export var health_component : HealthComponent
@export var damage_number_component : DamageNumbercomponent

func _ready():
	object = get_parent()

func damage(attack):
	if health_component:
		health_component.decreaseHp(attack)
		
	await  get_tree().create_timer(randf_range(0, .15)).timeout
	if damage_number_component:
		damage_number_component.makeDamageNumber(attack)
	
	if object:
		if object.has_method("got_damaged"):
			object.got_damaged()
