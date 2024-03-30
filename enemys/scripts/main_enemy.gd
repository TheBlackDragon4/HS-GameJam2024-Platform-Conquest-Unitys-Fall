extends CharacterBody2D

@export var speed = 250.0
@export var damage = 10.0
@export var aps = 2.0

var attack_speed
var time_until_attack
var within_attack_range = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.get_node("CharacterBody2D")
	attack_speed = 1/aps
	time_until_attack = attack_speed
	#print(CharacterBody2D.name())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if within_attack_range and time_until_attack <= 0:
		_attack();
		time_until_attack = attack_speed
	else:
		time_until_attack -= delta

func _attack():
	print("Attack player")

func _on_attack_range_body_enter(body):
	if body.is_in_group("CharacterBody2D"):
		print("Player in range")
		within_attack_range = true

func _on_attack_range_body_exit(body):
	if body.is_in_group("CharacterBody2D"):
		within_attack_range = false
		time_until_attack = attack_speed

