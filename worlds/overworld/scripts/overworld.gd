extends Node2D

@onready var pause_window = $Pause_Menu/Pause_Window
@onready var pause_window_blur = $Pause_Menu/Blur

@onready var player = $Node/CharacterBody2D/Sprite2D

@onready var tile_map = $Node/TileMap

@onready var camera = $Node/CharacterBody2D/Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# So that the camera can't move out of screen in the bottom
	camera.limit_bottom = get_viewport().get_visible_rect().size.y
	
	camera.limit_left = tile_map.get_used_rect().position.x * tile_map.tile_set.tile_size.x * tile_map.scale.x
	camera.limit_right = tile_map.get_used_rect().end.x * tile_map.tile_set.tile_size.x * tile_map.scale.x

	#print(map_to_world(get_viewport().get_visible_rect()))
	#print(tile_map.get_used_rect().end)
	#print(tile_map.tile_set.tile_size.x)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if Input.is_action_just_pressed("pause_game"):
		pause_window.visible = !pause_window.visible
		#blur disabled becaused its static, but the camera moves
		#pause_window_blur.visible = !pause_window_blur.visible
		Global.game_freeze = !Global.game_freeze
		


func _on_button_resume_pressed():
	pause_window.visible = !pause_window.visible
	#blur disabled becaused its static, but the camera moves
	#pause_window_blur.visible = !pause_window_blur.visible
	Global.game_freeze = !Global.game_freeze
	

func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_menu_pressed():
	pause_window.visible = false
	Global.game_freeze = false
	get_tree().change_scene_to_file("res://menu/scenes/main_menu.tscn")



