extends CharacterBody2D

@onready var player = get_parent().find_child("Player_1")
@onready var sprite = $Sprite2D
@onready var fsm = get_parent().find_child("1FiniteStateMachine")

var taking_damage :bool
var direction: Vector2
var DEF = 0
var distance: float

var max_health = 25
var health = 0
var dead = false

var damage_reduction_factor = 1.0

func _ready():
	taking_damage= false

	
	health = max_health
	
	set_physics_process(false)

func _process(_delta):
	if not player or dead:
		return
	
	direction = player.position - position
	
	
	if direction.x > 0:
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
	taking_damage=true
	
	health -= damage_amount * damage_reduction_factor
	print(health)
	get_node("HealthBar").update_healthbar(health, max_health)
	
	if health == max_health / 2:
		damage_reduction_factor = 0.5

	if health <= 0:
		die()

func die():
	dead = true
	$Attacking/CollisionShape2D.disabled=true
	$Attacking/CollisionShape2D2.disabled=true
	$AnimationPlayer.play("death")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(1.5).timeout
	queue_free()
	

func _on_take_damage_area_entered(area):
	if area.get_parent() is Player and not dead:
		
		take_damage(1)

func _on_attacking_area_entered(area):
	if area.get_parent() is Player :
		
		area.get_parent().take_damage(2.5)
	




