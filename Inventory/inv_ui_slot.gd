extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/Item_Display

func update(item: InvItem):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.scale.x = 40.0/float(item.texture.get_height())
		item_visual.scale.y = 40.0/float(item.texture.get_width())
		item_visual.texture = item.texture
