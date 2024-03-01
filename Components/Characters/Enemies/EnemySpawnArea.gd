extends Area2D

@onready var collision_polygon_2d = $CollisionPolygon2D

@export var entity_node : Node2D
@export var enemy_count := 1

var min_x
var min_y
var max_x
var max_y
var pos

func _ready():
	setMinMax()
	if entity_node:
		for x in range(enemy_count):
			spawnEnemies()

func setMinMax():
	for vector in collision_polygon_2d.polygon:
		if not min_x or vector.x < min_x:
			min_x = vector.x
		if not min_y or vector.y < min_y:
			min_y = vector.y
		if not max_x or vector.x > max_x:
			max_x = vector.x
		if not max_y or vector.y > max_y:
			max_y = vector.y

func spawnEnemies():
	var enemy = load("res://Characters/Enemies/Shroomy.tscn").instantiate()
	getRandomPosition()
	enemy.position = to_global(pos)
	entity_node.add_child(enemy)
	

func getRandomPosition():
	var random_point = Vector2(randi_range(min_x,max_x),randi_range(min_y,max_y))
	if not Geometry2D.is_point_in_polygon(random_point, collision_polygon_2d.polygon):
		await getRandomPosition()
	else:
		pos = random_point
