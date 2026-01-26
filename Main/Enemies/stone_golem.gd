extends CharacterBody2D


@onready var player = get_parent().find_child("Player_1")
@onready var sprite = $Sprite2D
@onready var fsm = get_parent().find_child("1FiniteStateMachine")


var direction: Vector2
var DEF = 0

var max_health = 20
var health = 0
var dead = false

var damage_reduction_factor = 1.0

func _ready():
	health = max_health
	
	set_physics_process(false)

func _process(_delta):
	if not player or dead:
		return
	
	direction = player.position - position

	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta):
	if dead:
		return

	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func take_damage(damage_amount):
	if dead:
		return

	health -= damage_amount * damage_reduction_factor
	print(health)
	get_node("HealthBar").update_healthbar(health, max_health)

	if health <= 0:
		die()

func die():
	dead = true
	fsm.change_state("Death")
	# Add any additional death handling here, e.g., animations, effects, etc.

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player and not dead:
		
		area.get_parent().take_damage(1.7)
		
	# else:
	#	collision_2.disabled = true
	#	collision_3.disabled = true

func hits():
	$Hitbox.monitoring = true

func end_of_hits():
	$Hitbox.monitoring = false


func _on_attacking_area_entered(area):
	if area.get_parent() is Player:
		$Hitbox/CollisionShape2D3/AnimationPlayer.play("On")
		$Hitbox/CollisionShape2D2/AnimationPlayer.play("On")


func _on_attacking_area_exited(area):
	if area.get_parent() is Player:
		$Hitbox/CollisionShape2D3/AnimationPlayer.play("Off")
		$Hitbox/CollisionShape2D2/AnimationPlayer.play("Off")
