extends Node

var template = {
	"name" : "Magic Name",
	"scene" : "scene/link",
	"unlocked" : false,
	"selected" : false
}

# Ranged
var firebolt = {
	"name" : "Fire Bolt",
	"scene" : "res://Misc/Magic/Ranged/FireBolt/FireBolt.tscn",
	"unlocked" : true,
	"selected" : true
}

var iceball = {
	"name" : "Ice Ball",
	"scene" : "res://Misc/Magic/Ranged/IceBall/IceBall.tscn",
	"unlocked" : true,
	"selected" : true
}

var magic_missile = {
	"name" : "Magic Missile",
	"scene" : "res://Misc/Magic/Ranged/MagicMissile/MagicMissileSpawner.tscn",
	"unlocked" : true,
	"selected" : true
}

var cards = [firebolt, iceball, magic_missile]
var deck = []

func _ready():
	for card in cards:
		if card["selected"]:
			deck.append(card)
