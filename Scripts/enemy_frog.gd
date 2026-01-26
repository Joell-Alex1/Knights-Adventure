extends CharacterBody2D

var current_speed = 0
var SPEED = 60
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = true
var dead = false
var max_health = 4
var health = 0
var can_take_damage = true
var can_attack = true
var hit = false

@onready var sprite = $Sprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

func _ready():
	health = max_health
	$AnimationPlayer.play("Hop")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Check collisions with raycasts
	if facing_right:
		if not ray_cast_right.is_colliding() and is_on_floor():
			flip()
	else:
		if not ray_cast_left.is_colliding() and is_on_floor():
			flip()
		
	velocity.x = SPEED
	move_and_slide()

func flip():
	facing_right = !facing_right
	sprite.flip_h = not facing_right
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player and not dead and can_attack:
		area.get_parent().take_damage(5)

func take_damage(damage_amount):
	if not dead:
		$AnimationPlayer.play("Hurt")
		health -= damage_amount
		get_node("HealthBar").update_healthbar(health, max_health)
		if health <= 0:
			die()

func get_hit():
	hit = not hit
	if hit:
		current_speed = SPEED
		SPEED = 0
		can_attack = false
	else:
		SPEED = current_speed
		can_attack = true
		$AnimationPlayer.play("Hop")
		
func die():
	dead = true
	SPEED = 0
	$AnimationPlayer.play("Death")
	
func hits():
	$AttackDetector.monitoring = true

func end_of_hits():
	$AttackDetector.monitoring = false
	$AnimationPlayer.play("Hop")

func _on_player_detect_area_entered(area):
	if area.get_parent() is Player and not dead and can_attack:
		$AnimationPlayer.play("Attack")
