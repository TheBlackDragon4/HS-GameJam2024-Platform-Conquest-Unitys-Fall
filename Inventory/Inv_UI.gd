extends Control

@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var inv_open = false
@onready var selectedSlot = $NinePatchRect/GridContainer/Inv_UI_Slot1
@onready var selectedSlotSprite = $NinePatchRect/GridContainer/Inv_UI_Slot1/Sprite2D
@onready var container = $NinePatchRect/GridContainer

func _ready():
	update_slots()
	close()

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
			selectedSlotSprite.animation = "default"
			selectedSlot = selectedSlot.get_focus_neighbor(focus_neighbor_left)
		if Input.is_action_just_pressed("right"):
			selectedSlotSprite.animation = "default"
			#print("Type: ", typeof(selectedSlot), " selectedSlot:", selectedSlot)
			#print("selectedSlot.get_focus_neighbor(focus_neighbor_right): ",selectedSlot.get_focus_neighbor(SIDE_RIGHT))
			#print("typeof(selectedSlot.get_focus_neighbor(focus_neighbor_right)): ",typeof(selectedSlot.get_focus_neighbor(SIDE_RIGHT)))
			selectedSlot = get_node(selectedSlot.focus_neighbor_right)
			#print($NinePatchRect/GridContainer.get_node(selectedSlot.get_focus_neighbor(SIDE_RIGHT)))
			#selectedSlot = $NinePatchRect/GridContainer.get_node(selectedSlot.focus_neighbor_right)
			print(selectedSlot.focus_neighbor_right.get_name(0))
			selectedSlot = container.getSlot(selectedSlot.focus_neighbor_right)
			print(selectedSlot)
			selectedSlot.get_node("Sprite2D").animation = "selected"
			#selectedSlotSprite.animation = "selected"

		if Input.is_action_just_pressed("jump"):
			selectedSlotSprite.animation = "default"
			selectedSlot = selectedSlot.get_focus_neighbor(focus_neighbor_top)
		if Input.is_action_just_pressed("interact"):
			selectedSlotSprite.animation = "default"
			selectedSlot = selectedSlot.get_focus_neighbor(focus_neighbor_bottom)


func close():
	get_parent().isFreezed = false
	inv_open = false
	visible = false

func open():
	get_parent().isFreezed = true
	inv_open = true
	visible = true
	#selectedSlot.get_node("Sprite2D").set_texture(preload(("res://icons/dummy/Selected_Inventory_Tile.png")))
	selectedSlotSprite.animation = "selected"
	print(selectedSlotSprite.animation)
