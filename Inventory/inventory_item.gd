extends Resource

class_name InvItem

@export var name: String
@export var texture: Texture2D
@export var damage: int

#
#func _init(p_name = "null", p_texture = null):
	#name = p_name
	#texture = p_texture

func _init(p_name = "null", p_texture = null, p_damage = 0):
	name = p_name
	texture = p_texture
	damage = p_damage
