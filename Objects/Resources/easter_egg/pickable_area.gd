extends Area2D

@onready var interact_label = $interact_label

var isNear = false

func _onready():
	interact_label.visible = false
	

func _process(_delta):
	if !get_parent().isPickedUp:
		for body in get_overlapping_bodies():
			if body.name == "CharacterBody2D":
				interact_label.visible = true
			else:
				interact_label.visible = false

func _input(event):
	if !get_parent().isPickedUp:
		if event.is_action_pressed("interact"):
			for body in get_overlapping_bodies():
				if body.name == "CharacterBody2D":
					get_parent().pickUp()
					interact_label.visible = false
					break
