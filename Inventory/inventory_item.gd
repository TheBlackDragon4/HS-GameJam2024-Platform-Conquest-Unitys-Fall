extends Resource

class_name InvItem

@export var name: String
@export var texture: Texture2D


func _init(p_name = "null", p_texture = null):
	name = p_name
	texture = p_texture
