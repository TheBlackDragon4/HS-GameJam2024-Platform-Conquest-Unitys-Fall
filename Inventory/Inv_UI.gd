extends Control

@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var inv_open = false

func _ready():
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_DELETE:
			print("DELETE was pressed")
			if inv_open:
				close()
			else:
				open()


func close():
	inv_open = false
	visible = false

func open():
	inv_open = true
	visible = true
