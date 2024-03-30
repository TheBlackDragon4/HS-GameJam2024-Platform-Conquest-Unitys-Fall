extends Node2D

@export var spawn_enemy: PackedScene

@export_range(0.1,10.0,0.1) var wait_time = 0.0
func _ready():
	$Timer.wait_time = wait_time
	
func _on_timer_timeout():
	
	var mob = spawn_enemy.instantiate()
	
	var node = $"."
	if node != null:
		print(node.position)
	else:
		print("Node wurde nicht gefunden!")
	
	print(node.position)
	print(node.position.x)
	print(node.position.y)
	
	mob.position = $".".position
	
	$".".add_child(mob)
