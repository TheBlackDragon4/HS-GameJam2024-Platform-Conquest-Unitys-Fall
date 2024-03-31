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
	if health < 0:
		#TODO:Death Animation
		crawler_sprite.play("death")
		queue_free()
		
