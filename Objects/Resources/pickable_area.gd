extends Area2D

@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")
@onready var interact_label = $interact_label

var isNear = false

func _onready():
	interact_label.visible = false
	

func _process(_delta):
	if !get_parent().isChopped:
		for body in get_overlapping_bodies():
			if body.name == "CharacterBody2D":
				interact_label.visible = true
			else:
				interact_label.visible = false

func _input(event):
	if !get_parent().isChopped:
		if event.is_action_pressed("interact"):
			for body in get_overlapping_bodies():
				if body.name == "CharacterBody2D":
					for array_item_index in range(1, inv.items.size()):
						#print(array_item_index)
						if inv.items[array_item_index] == null: 
							inv.items[array_item_index] = get_parent().item
							get_parent().chop_tree()
							interact_label.visible = false
							break
