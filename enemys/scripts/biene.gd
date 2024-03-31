extends CharacterBody2D

var speed = 10
const GRAVITY = 32
@export var health = Global.crawl_enemy_health

@onready var crawler_sprite = $Sprite2D
var reverse = false

func _physics_process(_delta):
	var enemy_position = $".".position
	var character_position = $"../CharacterBody2D".position
	if (reverse):
		if (character_position.distance_to(enemy_position)> 700):
			reverse = false
		velocity = character_position.direction_to(enemy_position)*200
	else:
		velocity = character_position.direction_to(enemy_position)*100*-1
	move_and_slide()

func attack(damage):
	health -= damage
	if health <= 0:
		crawler_sprite.play("death")

func _on_sprite_2d_animation_finished():
	queue_free()

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name.begins_with("CharacterBody2D"):
		reverse = true
