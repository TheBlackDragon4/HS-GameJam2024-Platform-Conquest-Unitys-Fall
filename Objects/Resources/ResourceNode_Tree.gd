extends Node2D

#@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")

var player_in_area = false
var isChopped = false
@onready var sprite = $Sprite2D
@onready var item: InvItem


func _ready():
	item = InvItem.new("icons/dummy/stick.png", load("res://icons/dummy/stick.png"))

func chop_tree():
	isChopped = true
	sprite.texture = preload("res://icons/dummy/Chopped_tree.png")
