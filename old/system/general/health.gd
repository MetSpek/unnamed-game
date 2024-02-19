extends Node

func decrease_hp(current_hp, damage):
	current_hp -= damage
	return current_hp

func check_death(current_hp):
	if current_hp <= 0:
		return true
	else:
		return false
