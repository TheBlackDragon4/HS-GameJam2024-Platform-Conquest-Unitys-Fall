extends Area2D

@export var sceneChanger: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		for body in get_overlapping_bodies():
			if body.name == "CharacterBody2D":
				get_tree().change_scene_to_file(sceneChanger+".tscn")
				#get_tree().change_scene_to_file("res://level/level1.tscn")
