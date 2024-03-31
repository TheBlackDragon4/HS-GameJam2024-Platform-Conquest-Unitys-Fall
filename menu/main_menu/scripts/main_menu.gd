extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("menu_first"):
		$MarginContainer/HBoxContainer/VBoxContainer/New_Game_Button.emit_signal("pressed")
	if Input.is_action_just_pressed("menu_second"):
		$MarginContainer/HBoxContainer/VBoxContainer/Quit_Button.emit_signal("pressed")

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://worlds/overworld/scenes/overworld.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://menu/credits/scenes/credits.tscn")
