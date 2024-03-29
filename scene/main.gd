extends Node2D

@onready var pause_window = $Pause_Menu/Pause_Window
@onready var pause_window_blur = $Pause_Menu/Blur

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause_game"):
		pause_window.visible = !pause_window.visible
		pause_window_blur.visible = !pause_window_blur.visible
		Global.game_freeze = !Global.game_freeze
		


func _on_button_resume_pressed():
	pause_window.visible = !pause_window.visible
	pause_window_blur.visible = !pause_window_blur.visible
	Global.game_freeze = !Global.game_freeze
	

func _on_button_quit_pressed():
	get_tree().quit()
