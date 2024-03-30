extends Node2D

var player_in_area = false
var isPickedUp = false
@onready var sprite = $Sprite2D


func pickUp():
	isPickedUp = true
	sprite.visible = false
	Global.easter_eggs_found += 1
	print(Global.easter_eggs_found)
