extends Area2D

@export var sceneChanger: String = ""
@onready var aSpride2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	

func _input(event):
	if event.is_action_pressed("open_door"):
		for body in get_overlapping_bodies():
			if body.name == "CharacterBody2D" and !aSpride2D.is_playing():
				aSpride2D.play("default", 1.0, false)
				aSpride2D.frame = 0				
				#get_tree().change_scene_to_file(sceneChanger+".tscn")
				#get_tree().change_scene_to_file("res://level/level1.tscn")

func _on_animated_sprite_2d_animation_looped():
	get_tree().change_scene_to_file(sceneChanger+".tscn")

