extends Area2D


func _input(event):
	if event.is_action_pressed("open_door"):
		for body in get_overlapping_bodies():
			if body.name == "enemy_Crawler":
				print("hit")
				print(body)
				body.attack(Global.player_base_damage)
