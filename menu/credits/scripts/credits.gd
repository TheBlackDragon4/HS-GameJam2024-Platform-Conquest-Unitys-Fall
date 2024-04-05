extends Node2D



func _input(event):
	if(Input.is_action_just_pressed("pause_game")):
		$VBoxContainer/Button.emit_signal("pressed")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu/main_menu/scenes/main_menu.tscn")
