extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -869.0
@onready var main_character_sprite = $Sprite2D
@onready var camera = $"Camera2D"

@onready var weapon_sprite: Sprite2D = null

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const border_size = 300

var isFreezed = false

func _physics_process(delta):
	if(Global.game_freeze):
		return 
		
	# Animations
	if (velocity.x > 1 || velocity.x < -1):
		main_character_sprite.animation = "running"
	else:
		main_character_sprite.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		main_character_sprite.animation = "jumping"

	# If opened Inventory
	if isFreezed:
		move_and_slide()
		if is_on_floor():
			velocity.x = 0
		return

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, 40)

	if(!Global.game_freeze):
		move_and_slide()
		var isLeft = velocity.x < 0
		main_character_sprite.flip_h = isLeft

#func _on_tree_body_entered(body):
	#$resource_tree.interact()

func _process(_delta):
	if Global.weapon:
		var EquipSprite = $HandEquip/EquipSprite
		EquipSprite.texture = Global.weapon.texture
