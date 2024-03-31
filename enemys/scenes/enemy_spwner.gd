extends Node2D

@export var spawn_enemy: PackedScene
@export var door: Node
@export_range(0.1,10.0,0.1) var wait_time = 0.0
@export_range(1,255) var spawncount = 0
var spawned_mobs = 0
var waveSpawend = false

func _ready():
	$Timer.wait_time = wait_time
	
func _on_timer_timeout():
	if (spawned_mobs < spawncount): 
		spawned_mobs += 1
		spawn_mob()
	else:
		waveSpawend = true
		$Timer.stop()

func _physics_process(_delta):
	if (waveSpawend):
		if ($".".get_child_count() == 1):
			if door != null:
				door.visible = true

func spawn_mob():
	var mob = spawn_enemy.instantiate()
	mob.position = $".".position
	$".".add_child(mob,true)
	
