extends Node

func slow_engine(slow_amount, slow_time):
	Engine.time_scale = slow_amount
	await get_tree().create_timer(slow_time  * slow_amount).timeout
	Engine.time_scale = 1
