extends Control

@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var inv_open = false
@onready var selectedSlot = $NinePatchRect/GridContainer/Inv_UI_Slot1
var slotArray = []
var currentPos = 0

@onready var dialog = $DeleteDialog
@onready var equipButton = $DeleteDialog/HBoxContainer/Equip
@onready var deleteButton = $DeleteDialog/HBoxContainer/Delete
@onready var cancelButton = $DeleteDialog/HBoxContainer/Cancel

func _ready():
	update_slots()
	close()
	for slot in $NinePatchRect/GridContainer.get_children():
		slotArray.append(slot)

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

func _process(_delta):
	if Input.is_action_just_pressed("Inventory") and dialog.visible:
			equipButton.emit_signal("pressed")
			dialog.visible = false
			#print("second: ",dialog.visible)
	if Input.is_action_just_pressed("menu_first") and dialog.visible:
			deleteButton.emit_signal("pressed")
			dialog.visible = false
			#print("first: ",dialog.visible)
	if Input.is_action_just_pressed("menu_second") and dialog.visible:
			cancelButton.emit_signal("pressed")
			dialog.visible = false
			#print("second: ",dialog.visible)

func _input(_event):
	if Input.is_action_just_pressed("interact"):
		update_slots()
	if Input.is_action_just_pressed("Inventory"):
		if inv_open:
			close()
		else:
			update_slots()
			open()
	if inv_open:
		var action = ""
		if Input.is_action_just_pressed("left"):
			action = "left"
		if Input.is_action_just_pressed("right"):
			action = "right"
		if Input.is_action_just_pressed("jump"):
			action = "jump"
		if Input.is_action_just_pressed("interact"):
			action = "interact"
		
		selectedSlot.get_node("Sprite2D").animation = "default"
		
		match action:
			"left":
				if currentPos > 0:
					currentPos = currentPos-1
				else:
					currentPos = currentPos-1+12
			"right":
				if currentPos < 9:
					currentPos = currentPos+1
				else:
					currentPos = currentPos+1-12
			"jump":
				if currentPos > 3:
					currentPos = currentPos-4
				else:
					currentPos = currentPos+12-4
			"interact":
				if currentPos < 8:
					currentPos = currentPos-8+4
				else:
					currentPos = currentPos+4
					
		selectedSlot = slotArray[currentPos]
		selectedSlot.get_node("Sprite2D").animation = "selected"
		
		if Input.is_action_just_pressed("delete_item"):
			if inv.items[currentPos] != null and currentPos != 0:
				dialog.visible = true

func close():
	get_parent().isFreezed = false
	inv_open = false
	visible = false

func open():
	get_parent().isFreezed = true
	inv_open = true
	visible = true
	selectedSlot.get_node("Sprite2D").animation = "selected"

func _on_delete_pressed():
	inv.items[currentPos] = null
	update_slots()

func _on_equip_pressed():
	var prevEquipedItem = inv.items[0]
	inv.items[0] = inv.items[currentPos]
	inv.items[currentPos] = prevEquipedItem
	update_slots()
