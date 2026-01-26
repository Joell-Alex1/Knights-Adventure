extends CharacterBody2D


@onready var player = get_parent().find_child("Player_1")
@onready var sprite = $Sprite2D
@onready var fsm = get_parent().find_child("2FiniteStateMachine")


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
	fsm.change_state("Stagger")
	if health <= 0:
		die()

func die():
	dead = true
	fsm.change_state("Death")
