extends Control

var inv_open = false

func _ready():
	close()

func _process(delta):
	if Input.is_action_just_pressed("KEY_DELETE"):
		if inv_open:
			close()
		else:
			open()

func close():
	inv_open = false
	visible = false

func open():
	inv_open = true
	visible = true
