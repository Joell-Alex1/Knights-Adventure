extends CharacterBody2D

@export var speed = 200.0
@export var jump_velocity = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $Sprite2D

func _physics_process(delta):
	# Handle left and right movement
	var direction = 0
	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1
	velocity.x = direction * speed

	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jumping
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_velocity

	# Move and slide with collision
	move_and_slide()

	# Flip the sprite based on the direction
	if direction != 0:
		sprite.flip_h = direction < 0
