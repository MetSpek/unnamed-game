extends Area2D

@onready var health = $"../Health"

func hit(damage):
	print(damage)
