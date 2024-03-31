extends Node2D

@onready var pause_window = $Pause_Menu/Pause_Window

@onready var player = $Node/CharacterBody2D/Sprite2D
@onready var tile_map = $Node/TileMap
@onready var camera = $Node/CharacterBody2D/Camera2D

@onready var pause_menu_window = $Pause_Menu/Pause_Window
@onready var pause_menu_button1 = $Pause_Menu/Pause_Window/VBoxContainer/Button_resume
@onready var pause_menu_button2 = $Pause_Menu/Pause_Window/VBoxContainer/Button_menu
@onready var border_left = $"Node/World Boarder/left_container/left"
@onready var border_right = $"Node/World Boarder/right_container/right"
@onready var border_top = $"Node/World Boarder/top_container/top"
@onready var border_bottom = $"Node/World Boarder/bottom_container/bottom"

const border_height_offset = 800


# Called when the node enters the scene tree for the first time.
func _ready():
	
	if Global.level_completed[0] == true:
		get_tree().change_scene_to_file("res://menu/credits/scenes/credits.tscn")
	
	var world_rect = tile_map.get_used_rect()
	var tile_to_pixel_factor = tile_map.tile_set.tile_size.x * tile_map.scale.x
	
	# World border
	# left
	border_left.disabled = false
	border_left.shape.a.x = world_rect.position.x * tile_to_pixel_factor # Links oben
	border_left.shape.a.y = world_rect.position.y * tile_to_pixel_factor - border_height_offset
	border_left.shape.b.x = world_rect.position.x * tile_to_pixel_factor # Links unten
	border_left.shape.b.y = world_rect.end.y * tile_to_pixel_factor
	# right
	border_right.disabled = false
	border_right.shape.a.x = world_rect.end.x * tile_to_pixel_factor # Rechts oben
	border_right.shape.a.y = world_rect.position.y * tile_to_pixel_factor - border_height_offset
	border_right.shape.b.x = world_rect.end.x * tile_to_pixel_factor # Rechts unten
	border_right.shape.b.y = world_rect.end.y * tile_to_pixel_factor
	# top
	border_top.disabled = false
	border_top.shape.a.x = world_rect.position.x * tile_to_pixel_factor # Links oben
	border_top.shape.a.y = world_rect.position.y * tile_to_pixel_factor - border_height_offset
	border_top.shape.b.x = world_rect.end.x * tile_to_pixel_factor # Rechts oben
	border_top.shape.b.y = world_rect.position.y * tile_to_pixel_factor - border_height_offset
	# bottom
	border_bottom.disabled = false
	border_bottom.shape.a.x = world_rect.position.x * tile_to_pixel_factor # Links unten
	border_bottom.shape.a.y = world_rect.end.y * tile_to_pixel_factor
	border_bottom.shape.b.x = world_rect.end.x * tile_to_pixel_factor # Rechts unten
	border_bottom.shape.b.y = world_rect.end.y * tile_to_pixel_factor
	
	# So that the camera can't move out of screen in the bottom
	camera.limit_bottom = get_viewport().get_visible_rect().size.y
	camera.limit_left = world_rect.position.x * tile_to_pixel_factor
	camera.limit_right = world_rect.end.x * tile_to_pixel_factor
	camera.limit_top = world_rect.position.y * tile_to_pixel_factor - border_height_offset




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Input.is_action_just_pressed("menu_first") and pause_menu_window.visible:
		pause_menu_button1.emit_signal("pressed")
	if Input.is_action_just_pressed("menu_second") and pause_menu_window.visible:
		pause_menu_button2.emit_signal("pressed")
	
	

	
func _input(_event):
	if Input.is_action_just_pressed("pause_game"):
		pause_window.visible = !pause_window.visible
		Global.game_freeze = !Global.game_freeze
	if Input.is_action_just_pressed("cheat_force_all_levels_complete"):
		Global.level_completed[1] = true
		Global.level_completed[2] = true
		Global.level_completed[3] = true
		Global.level_completed[4] = true
		Global.level_completed[5] = true
		Global.level_completed[6] = true
	
	

func _on_button_resume_pressed():
	pause_window.visible = !pause_window.visible
	Global.game_freeze = !Global.game_freeze
	

func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_menu_pressed():
	pause_window.visible = false
	Global.game_freeze = false
	get_tree().change_scene_to_file("res://menu/main_menu/scenes/main_menu.tscn")



