extends Area2D

@export var sceneChanger: String = ""
@onready var aSpride2D = $AnimatedSprite2D
@onready var index_level_completed = int(sceneChanger.substr(sceneChanger.length()-1,sceneChanger.length()))

# Called when the node enters the scene tree for the first time.

func _input(event):
	if event.is_action_pressed("open_door") and !Global.level_completed[index_level_completed]:
		if sceneChanger == "worlds/level/scenes/Finallevel0":
			if Global.level_completed[1] == true and Global.level_completed[2] and Global.level_completed[3] and Global.level_completed[4] and Global.level_completed[5] and Global.level_completed[6]:
				start_door_open()
		else:
			start_door_open()
		
func start_door_open():
	for body in get_overlapping_bodies():
			if body.name == "CharacterBody2D" and !aSpride2D.is_playing():
				aSpride2D.play("default", 1.0, false)
				aSpride2D.frame = 0

func _on_animated_sprite_2d_animation_looped():
	if sceneChanger.begins_with("worlds/level/scenes/level"):
		Global.level_completed[index_level_completed] = true
	get_tree().change_scene_to_file(sceneChanger+".tscn")


