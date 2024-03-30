extends Control

@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var inv_open = false
@onready var selectedSlot = $NinePatchRect/GridContainer/Inv_UI_Slot1
#@onready var selectedSlotSprite = $NinePatchRect/GridContainer/Inv_UI_Slot1/Sprite2D
var slotArray = []
var currentPos = 0


func _ready():
	update_slots()
	close()
	for slot in $NinePatchRect/GridContainer.get_children():
		slotArray.append(slot)

func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

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
		if Input.is_action_just_pressed("left"):
			if !currentPos < 1:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos-1
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"
			else:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos-1+12
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"				
		if Input.is_action_just_pressed("right"):
			if !currentPos > 10:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos+1
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"
			else:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos+1-12
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"
		if Input.is_action_just_pressed("jump"):
			if !currentPos < 4:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos-4
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"
			else:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos+12-4
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"
		if Input.is_action_just_pressed("interact"):
			if !currentPos > 7:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos+4
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"
			else:
				selectedSlot.get_node("Sprite2D").animation = "default"
				currentPos = currentPos-12+4
				selectedSlot = slotArray[currentPos]
				selectedSlot.get_node("Sprite2D").animation = "selected"
				


func close():
	get_parent().isFreezed = false
	inv_open = false
	visible = false

func open():
	get_parent().isFreezed = true
	inv_open = true
	visible = true
	#selectedSlot.get_node("Sprite2D").set_texture(preload(("res://icons/dummy/Selected_Inventory_Tile.png")))
	selectedSlot.get_node("Sprite2D").animation = "selected"
