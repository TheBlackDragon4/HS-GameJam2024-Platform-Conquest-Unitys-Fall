extends Node2D

@onready var door = $Door

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(_event):
	if Input.is_action_just_pressed("cheat_force_door"):
		door.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#pass
