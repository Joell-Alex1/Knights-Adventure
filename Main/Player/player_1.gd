extends CharacterBody2D
class_name Player

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision_shape = $AttackArea/CollisionShape2D
@onready var shield_protection = $ShieldProtection
@onready var health_bar = $playerHealth

const SPEED = 100.0
const SHIELD_SPEED_MULTIPLIER = 0.5  # Multiplier for speed reduction while shielding
const JUMP_VELOCITY = -350.0
const KNOCKBACK_DISTANCE = 10.0  # Distance to move back when shielding

@export var climbing = false
var dead : bool
var Bat : CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var hit = false
@export var attacking = false
var shielding = false

var max_health = 20
var health = 0
var can_take_damage = true
var damage_factor = 1.0  # Default damage factor
var respawn_count   # Track the number of respawns

func _ready():
	respawn_count=0
	health = max_health
	update_health()
	print(health)
	GameM.DamageDealt = true
	GameM.playerAlive = true
	
	can_take_damage = true
	dead = false
	GameM.player = self
	
	shield_protection.visible = false
	shield_protection.get_node("CollisionShape2D").disabled = true

func _process(delta):
	if Input.is_action_just_pressed("Attack") and not attacking:
		attack()

	shielding = Input.is_action_pressed("shield")
	if shielding:
		shield_protection.visible = true
		shield_protection.get_node("CollisionShape2D").disabled = false
		damage_factor = 0.25  # Reduce damage taken when shielding
	else:
		shield_protection.visible = false
		shield_protection.get_node("CollisionShape2D").disabled = true
		damage_factor = 1.0  # Normal damage taken

	update_animation()

func _physics_process(delta):
	GameM.playerDamageZone = collision_shape
	if not is_on_floor():
		velocity.y += gravity * delta

	if not dead:
		var speed = SPEED
		if shielding:
			speed *= SHIELD_SPEED_MULTIPLIER  # Reduce speed while shielding

		if Input.is_action_pressed("left"):
			sprite.scale.x = abs(sprite.scale.x) * -1
			$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
			shield_protection.scale.x = -1
		elif Input.is_action_pressed("right"):
			sprite.scale.x = abs(sprite.scale.x)
			$AttackArea.scale.x = abs($AttackArea.scale.x)
			shield_protection.scale.x = 1

		if not shielding and Input.is_action_just_pressed("up") and is_on_floor():
			if not climbing:
				velocity.y = JUMP_VELOCITY
			elif climbing:
				velocity.y = -SPEED

		var direction = Input.get_axis("left", "right")
		if direction != 0:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

		if position.y >= 250:
			reduce_health_by_half()
			die()

	move_and_slide()

func reduce_health_by_half():
	health = max(health / 2, 5)  # Reduce health by half but ensure it's at least 1
	update_health()

func update_health():
	if health_bar:
		health_bar.update_healthbar(health, max_health)

func attack():
	if not dead:
		attacking = true
		animation.play("Attack")
		$Sprite2D/AnimatedSprite2D.play("default")  # Ensure default animation plays after attack animation
		# Add a timer to reset the attacking state after the attack animation duration
		var attack_duration = animation.get_animation("Attack").length
		await get_tree().create_timer(attack_duration).timeout
		attacking = false

		var overlapping_objects = $AttackArea.get_overlapping_areas()
		for area in overlapping_objects:
			if area.get_parent().is_in_group("Enemies"):
				area.get_parent().take_damage(1.2)

func update_animation():
	if not dead:
		if attacking:
			animation.play("Attack")
			$Sprite2D/AnimatedSprite2D.play("default")
		elif hit:
			animation.play("Hurt")
		elif shielding:
			animation.play("Shield")
		elif velocity.x != 0:
			animation.play("running")
		elif velocity.y < 0:
			animation.play("jump")
		else:
			animation.play("Idle")

func take_damage(damage):
	if can_take_damage and not shielding and GameM.playerAlive:
		print("player :", damage)
		iframes()
		hit = true
		attacking = false
		animation.play("Hurt")
		var direction = (position - get_parent().get_node("Player_1").position).normalized()
		health -= damage * damage_factor
		update_health()  # Update health instantly after taking damage
		knockback(direction * KNOCKBACK_DISTANCE)
	else:
		var reduced_damage = damage * damage_factor
		health -= reduced_damage
		print("Player took reduced damage while shielding:", reduced_damage)
		update_health()  # Update health instantly after taking damage

	if health <= 0:
		can_take_damage=false
		GameM.playerAlive = false
		attacking = false
		velocity.x = 0
		die()

func die():
	update_health()
	can_take_damage = false
	dead = true
	animation.play("die")
	velocity.x = 0
	await get_tree().create_timer(0.5).timeout
	$Camera2D.zoom.x = 2.4
	$Camera2D.zoom.y = 2.4
	
	# Respawn player after delay
	respawn()

func respawn():
	if dead:
		print(respawn_count)
		if respawn_count ==3:
			GameM.playerAlive = true
			velocity.x=SPEED
			respawn_count = 0
			await get_tree().create_timer(1.0).timeout
			get_tree().reload_current_scene()
		else:
			GameM.playerAlive = true
			position = GameM.current_checkpoint.global_position
			velocity = Vector2.ZERO
			health = max(health / 2, 5)  # Reduce health by half but ensure it's at least 1
			update_health()
			dead = false
			can_take_damage = true
			GameM.playerAlive = true
			animation.play("Idle")
			respawn_count = respawn_count+1

func iframes() -> void:
	can_take_damage = false
	await get_tree().create_timer(1.0).timeout  # 1 second of invincibility
	can_take_damage = true

func knockback(knockback_vector: Vector2):
	position += knockback_vector

func reset_health():
	can_take_damage=true
	health = max_health  # Reset health to max health value
	update_health()
