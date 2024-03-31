extends CharacterBody2D

var speed = 100
const GRAVITY = 32
@export var health = Global.crawl_enemy_health

@onready var crawler_sprite = $Sprite2D

func _physics_process(_delta):
	velocity.y += GRAVITY
	if (velocity.x == 0):
		speed *= -1
		velocity.x = speed
	move_and_slide()

func attack(damage):
	health -= damage
	if health <= 0:
		#TODO:Death Animation
		crawler_sprite.play("death")
		#queue_free()
		


func _on_sprite_2d_animation_finished():
	queue_free()


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name.begins_with("CharacterBody2D"):
		body.attack(Global.crawler_base_damage)# Replace with function body.
