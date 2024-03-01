extends Node2D
class_name DamageNumber

@onready var damage_label = $DamageLabel
@onready var suicide_timer = $SuicideTimer

@export var duration := .5
@export var speed := 50

var color := Color.WHITE
var damage : int
var direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	damage_label.set_deferred("font_color", color)
	damage_label.text = str(damage)
	suicide_timer.wait_time = duration
	suicide_timer.start()
	direction = Vector2(randf_range(-speed, speed), -speed)

func _process(delta):
	position += direction * delta

func _on_suicide_timer_timeout():
	queue_free()
