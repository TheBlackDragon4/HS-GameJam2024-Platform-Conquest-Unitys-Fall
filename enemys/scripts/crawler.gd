extends CharacterBody2D

var speed = 100
const GRAVITY = 32
@export var health = Global.crawl_enemy_health

func _physics_process(_delta):
	velocity.y += GRAVITY
	if (velocity.x == 0):
		speed *= -1
		velocity.x = speed
	move_and_slide()

