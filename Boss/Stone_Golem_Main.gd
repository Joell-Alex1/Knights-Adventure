extends CharacterBody2D


@onready var player = get_parent().find_child("Player_1")
@onready var sprite = $Sprite2D
@onready var fsm = get_parent().find_child("FiniteStateMachine")


var direction: Vector2
var DEF = 0

var max_health = 30
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
	if health==max_health/2:
		damage_reduction_factor = 0.3
		fsm.change_state("ArmourBuff")
		
	elif health <= 0:
		die()

func die():
	dead = true
	fsm.change_state("Death")
	# Add any additional death handling here, e.g., animations, effects, etc.

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player and not dead:
		
		area.get_parent().take_damage(2.8)
		
	# else:
	#	collision_2.disabled = true
	#	collision_3.disabled = true

func hits():
	$Hitbox.monitoring = true

func end_of_hits():
	$Hitbox.monitoring = false

func hit():
	$Pivot/LaserArea.monitoring = true

func end_of_hit():
	$Pivot/LaserArea.monitoring = false


#func _on_attacking_area_entered(area):
	#if area.get_parent() is Player:
		#await get_tree().create_timer(1.5).timeout
		#$Hitbox/CollisionShape2D3/AnimationPlayer.play("On")
		#$Hitbox/CollisionShape2D2/AnimationPlayer.play("On")
#func _on_attacking_area_exited(area):
	#
	#$Hitbox/CollisionShape2D3/AnimationPlayer.play("OFF")
	#$Hitbox/CollisionShape2D2/AnimationPlayer.play("OFF")


func _on_laser_area_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(4)
	





