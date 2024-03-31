extends Control

@onready var inv: Inv = preload("res://Inventory/player_inventory.tres")
@onready var craft: Inv = preload("res://Inventory/crafting/player_crafting_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var craft_slots: Array = $NinePatchCrafting/GridContainer.get_children()

var inv_open = false
@onready var selectedSlot = $NinePatchRect/GridContainer/Inv_UI_Slot1
@onready var selectedSlotCrafting = $NinePatchCrafting/GridContainer/Craft_UI_Slot1
var slotArray = []
var craftArray = []
var currentPos = 0
var craftingPos = -1
var selectMode = "inv" # inv or craft

var firstRun = true
var oldCraftingPos

var invMovementAllowed = true

@onready var dialog = $DeleteDialog
@onready var equipButton = $DeleteDialog/HBoxContainer/Equip
@onready var deleteButton = $DeleteDialog/HBoxContainer/Delete
@onready var cancelButton = $DeleteDialog/HBoxContainer/Cancel

@onready var craftDialog = $CraftingDialog
@onready var craftButton = $CraftingDialog/VBoxContainer/Craft
@onready var removeButton = $CraftingDialog/VBoxContainer/Remove
@onready var insertButton = $CraftingDialog/VBoxContainer/Insert

@onready var weapon = slots[0]

# ---- Sprite gen
@onready var equipSprite = get_parent().get_node("HandEquip").get_child(0)


# Anzahl der Texturen in horizontaler und vertikaler Richtung
var rows = 3
var cols = 3

# Liste der Texturen
var textures = [preload("res://icons/dummy/stick.png"),
preload("res://icons/dummy/stick2.png"),
preload("res://icons/dummy/stick3.png"),
preload("res://icons/dummy/stick5.png"),
preload("res://icons/dummy/stick9.png")]

@onready var canvas_layer = get_parent().get_node("CanvasLayer")
# ----


func _ready():
	for i in range(0, 11):
		if inv.items[i] != null:
			inv.items[i] = null
	inv.items[0] = InvItem.new("Stick", preload("res://icons/dummy/stick.png"), 20)
	Global.weapon = inv.items[0]
	update_slots()
	close()
	for slot in $NinePatchRect/GridContainer.get_children():
		slotArray.append(slot)
	for slot in $NinePatchCrafting/GridContainer.get_children():
		craftArray.append(slot)
	
	# ---- Sprite gen
	# Texturen laden (Hier fügen Sie Ihre Texturen hinzu)
	for i in range(rows * cols):
		var texture = load("res://icons/dummy/stick.png")
		textures.append(texture)


func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])
	for i in range(min(craft.items.size(), craft_slots.size())):
		craft_slots[i].update(craft.items[i])

func _process(_delta):
	if Input.is_action_just_pressed("Inventory") and dialog.visible:
			equipButton.emit_signal("pressed")
			dialog.visible = false
	if Input.is_action_just_pressed("menu_first") and dialog.visible:
			deleteButton.emit_signal("pressed")
			dialog.visible = false
	if Input.is_action_just_pressed("menu_second") and dialog.visible:
			cancelButton.emit_signal("pressed")
			dialog.visible = false
			
	#print(equipSprite.offset)
	#print(equipSprite)


func _input(_event):
	if Input.is_action_just_pressed("start_crafting") and craftDialog.visible:
			craftButton.emit_signal("pressed")
			craftDialog.visible = false
			invMovementAllowed = true
	if Input.is_action_just_pressed("crafting_insert") and craftDialog.visible:
			insertButton.emit_signal("pressed")
			craftDialog.visible = false
			invMovementAllowed = true
	if Input.is_action_just_pressed("delete_item") and craftDialog.visible:
			removeButton.emit_signal("pressed")
			craftDialog.visible = false
			invMovementAllowed = true

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
		
		
		if selectMode == "inv" and currentPos > -1:
			selectedSlot.get_node("Sprite2D").animation = "default"
		else:
			selectedSlotCrafting.get_node("Sprite2D").animation = "default"
		
		if invMovementAllowed:
			match action:
				"left":
					if selectMode == "inv":
						match currentPos:
							0:
								currentPos = -1
								craftingPos = 2
								selectMode = "craft"
							4:
								currentPos = -1
								craftingPos = 5
								selectMode = "craft"
							8:
								currentPos = -1
								craftingPos = 8
								selectMode = "craft"
							_:
								if currentPos != -1:
									currentPos = currentPos-1
									selectMode = "inv"
					else:
						match craftingPos:
							0:
								currentPos = 3
								craftingPos = -1
								selectMode = "inv"
							3:
								currentPos = 7
								craftingPos = -1
								selectMode = "inv"
							6:
								currentPos = 11
								craftingPos = -1
								selectMode = "inv"
							_:
								if craftingPos != -1:
									craftingPos = craftingPos-1
									selectMode = "craft"
								
				"right":
					if selectMode == "inv":
						match currentPos:
							3:
								currentPos = -1
								craftingPos = 0
								selectMode = "craft"
							7:
								currentPos = -1
								craftingPos = 3
								selectMode = "craft"
							11:
								currentPos = -1
								craftingPos = 6
								selectMode = "craft"
							_:
								if currentPos != -1:
									currentPos = currentPos+1
									selectMode = "inv"
					else:
						match craftingPos:
							2:
								currentPos = 0
								craftingPos = -1
								selectMode = "inv"
							5:
								currentPos = 4
								craftingPos = -1
								selectMode = "inv"
							8:
								currentPos = 8
								craftingPos = -1
								selectMode = "inv"
							_:
								if craftingPos != -1:
									craftingPos = craftingPos+1
									selectMode = "craft"
								
				"jump":
					if selectMode == "inv":
						match currentPos:
							0:
								currentPos = 8
								craftingPos = -1
								selectMode = "inv"
							1:
								currentPos = 9
								craftingPos = -1
								selectMode = "inv"
							2:
								currentPos = 10
								craftingPos = -1
								selectMode = "inv"
							3:
								currentPos = 11
								craftingPos = -1
								selectMode = "inv"
							_:
								if currentPos != -1:
									currentPos = currentPos-4
									selectMode = "inv"
					else:
						match craftingPos:
							0:
								currentPos = -1
								craftingPos = 6
								selectMode = "craft"
							1:
								currentPos = -1
								craftingPos = 7
								selectMode = "craft"
							2:
								currentPos = -1
								craftingPos = 8
								selectMode = "craft"
							_:
								if craftingPos != -1:
									craftingPos = craftingPos-3
									selectMode = "craft"
									
				"interact":
					if selectMode == "inv":
						match currentPos:
							8:
								currentPos = 0
								craftingPos = -1
								selectMode = "inv"
							9:
								currentPos = 1
								craftingPos = -1
								selectMode = "inv"
							10:
								currentPos = 2
								craftingPos = -1
								selectMode = "inv"
							11:
								currentPos = 3
								craftingPos = -1
								selectMode = "inv"
							_:
								if currentPos != -1:
									currentPos = currentPos+4
									selectMode = "inv"
					else:
						match craftingPos:
							6:
								currentPos = -1
								craftingPos = 0
								selectMode = "craft"
							7:
								currentPos = -1
								craftingPos = 1
								selectMode = "craft"
							8:
								currentPos = -1
								craftingPos = 2
								selectMode = "craft"
							_:
								if craftingPos != -1:
									craftingPos = craftingPos+3
									selectMode = "craft"
						
		if selectMode == "inv" and currentPos > -1:
			selectedSlot = slotArray[currentPos]
			selectedSlot.get_node("Sprite2D").animation = "selected"
		elif craftingPos > -1:
			selectedSlotCrafting = craftArray[craftingPos]
			selectedSlotCrafting.get_node("Sprite2D").animation = "selected"
		
		if Input.is_action_just_pressed("delete_item"):
			if inv.items[currentPos] != null and currentPos != 0:
				dialog.visible = true
		if Input.is_action_just_pressed("open_door"):
			if selectMode == "craft":
				craftDialog.visible = true
				invMovementAllowed = false

		# Siehe _on_insert_pressed()!
		if Input.is_action_just_pressed("confirm_insert") and craftingPos == -1:
			#print("Pressed L")
			var tempSlot = selectedSlot
			var oldCurrentPos = currentPos
			var usedCraftItem
			craftingPos = oldCraftingPos
			currentPos = -1
			selectMode = "craft"
			selectedSlotCrafting = tempSlot
			if craft.items[oldCraftingPos] != null:
				usedCraftItem = craft.items[oldCraftingPos]
			craft.items[oldCraftingPos] = inv.items[oldCurrentPos]
			inv.items[oldCurrentPos] = usedCraftItem
			update_slots()

func close():
	get_parent().isFreezed = false
	inv_open = false
	visible = false
	dialog.visible = false
	craftDialog.visible = false
	invMovementAllowed = true

func open():
	get_parent().isFreezed = true
	inv_open = true
	visible = true
	if currentPos > -1:
		selectedSlot.get_node("Sprite2D").animation = "selected"

func _on_delete_pressed():
	inv.items[currentPos] = null
	update_slots()

func _on_equip_pressed():
	var prevEquipedItem = inv.items[0]
	inv.items[0] = inv.items[currentPos]
	inv.items[currentPos] = prevEquipedItem
	Global.weapon = inv.items[0]
	update_slots()

func _on_craft_pressed():
	update_slots()
	var countCraftItems = 0
	for i in range(8):
		if craft.items[i] != null:
			countCraftItems = countCraftItems + 1
	#if craft.items.count(InvItem) > 0:
	if countCraftItems > 0:
		var counter = 0    
		#print("i am here")
		for i in range(8):
			if craft.items[i] != null:
				for tex in range(5):
					if craft.items[i].texture == textures[tex]:
						#print(craft.items[i].texture, textures[tex])
						counter = counter + tex+1
					#print(textures. craft.items[i].texture == <CompressedTexture2D#-9223371998149737140>)
				#var path = craft.items[i].texture
				#var regex = path.match("stick(\\d+)")
				#if regex:
					#var number_after_stick = regex[1]
					#counter = counter + number_after_stick
					#print("Number after 'stick':", number_after_stick)
					#craft.items[i] = null
		print(counter)
		match counter:
			1:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick.png"), 20)
						break
			2:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick2.png"), 25)
						break
			3:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick3.png"), 33)
						break
			4:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick3.png"), 35)
						break
			5:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick5.png"), 40)
						break
			6:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick5.png"), 45)
						break
			7:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick5.png"), 55)
						break
			8:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick5.png"), 65)
						break
			9:
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick9.png"), 75)
						break
			_: 
				for array_item_index in range(1, inv.items.size()):
					#print(array_item_index)
					if inv.items[array_item_index] == null: 
						inv.items[array_item_index] = InvItem.new("Stick", preload("res://icons/dummy/stick.png"), 20)
						break
			
		for i in range(8):
			craft.items[i] = null
			
		update_slots()


func _on_remove_pressed():
	selectedSlotCrafting.get_node("Sprite2D").animation = "default"
	for array_item_index in range(1, inv.items.size()):
		if inv.items[array_item_index] == null: 
			inv.items[array_item_index] = craft.items[craftingPos]
			craft.items[craftingPos] = null
			update_slots()
			break


func _on_insert_pressed():	
	if firstRun:
		firstRun = false
	selectedSlotCrafting.get_node("Sprite2D").animation = "crafting"
	oldCraftingPos = craftingPos
	currentPos = 0
	craftingPos = -1
	selectMode = "inv"
	selectedSlot = slotArray[currentPos]
	selectedSlot.get_node("Sprite2D").animation = "selected"
	update_slots()

	

