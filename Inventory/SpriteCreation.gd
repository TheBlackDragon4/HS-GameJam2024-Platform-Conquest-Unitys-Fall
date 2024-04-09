extends Node2D

@onready var equipSprite = get_parent().getEquipSprite()

# Anzahl der Texturen in horizontaler und vertikaler Richtung
var rows = 3
var cols = 3

# Liste der Texturen
var textures = []

func _ready():
	# Texturen laden (Hier fügen Sie Ihre Texturen hinzu)
	for i in range(rows * cols):
		var texture = load("res://icons/dummy/stick.png")
		textures.append(texture)

	# CanvasLayer erstellen, um die Texturen zu kombinieren
	#var canvas_layer = get_parent().getget_parent().get_node("CanvasLayer")
	var canvas_layer = get_parent().get_node("CanvasLayer")
	add_child(canvas_layer)

	# Texturen in CanvasLayer zeichnen
	for y in range(rows):
		for x in range(cols):
			var index = y * cols + x
			var texture = textures[index]
			var sprite = Sprite2D.new()
			sprite.texture = texture
			sprite.position.x = x * texture.get_width()
			sprite.position.y = y * texture.get_height()
			#canvas_layer.add_child(sprite)
			canvas_layer.add_child(sprite)
			#canvas_layer.offset = equipSprite.global_position
	#canvas_layer.offset = get_parent().getEquipSprite().offset
