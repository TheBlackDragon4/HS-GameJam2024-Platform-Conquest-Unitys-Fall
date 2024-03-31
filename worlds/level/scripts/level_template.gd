extends Node2D

@onready var door = $Door

@onready var pause_menu_window = $Pause_Menu/Pause_Window
@onready var pause_menu_button1 = $Pause_Menu/Pause_Window/VBoxContainer/Button_resume
@onready var pause_menu_button2 = $Pause_Menu/Pause_Window/VBoxContainer/Button_menu

@onready var pause_window = $Pause_Menu/Pause_Window

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(_delta):
	
	if Input.is_action_just_pressed("menu_first") and pause_menu_window.visible:
		pause_menu_button1.emit_signal("pressed")
	if Input.is_action_just_pressed("menu_second") and pause_menu_window.visible:
		pause_menu_button2.emit_signal("pressed")
	

func _input(_event):
	if Input.is_action_just_pressed("cheat_force_door"):
		door.visible = true
		
	if Input.is_action_just_pressed("pause_game"):
		pause_window.visible = !pause_window.visible
		Global.game_freeze = !Global.game_freeze


func _on_button_resume_pressed():
	pause_window.visible = !pause_window.visible
	Global.game_freeze = !Global.game_freeze
	

func _on_button_menu_pressed():
	pause_window.visible = false
	Global.game_freeze = false
	get_tree().change_scene_to_file("res://menu/main_menu/scenes/main_menu.tscn")
	
