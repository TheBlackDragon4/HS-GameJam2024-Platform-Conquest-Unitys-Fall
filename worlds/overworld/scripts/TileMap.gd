extends TileMap

#@onready var tile_map = self
#@onready var tile_map = $Node/TileMap

#@onready var camera = $Node/Camera2D
#@onready var camera = $CharacterBody2D/Camera2D


# Called when the node enters the scene tree for the first time.
#func _ready():
	
	# So that the camera can't move out of screen in the bottom
	#camera.limit_bottom = get_viewport().get_visible_rect().size.y
	
	#camera.limit_left = tile_map.get_used_rect().position.x * tile_map.cell_size #tile_set.tile_size.x

	#print(map_to_world(get_viewport().get_visible_rect()))
	#print(tile_map.get_used_rect())
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

