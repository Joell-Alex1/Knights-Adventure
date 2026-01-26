extends CharacterBody2D

@onready var player = get_parent().find_child("Player_1")
@onready var sprite = $Sprite2D
@onready var collision_shape = $PlayerHit/CollisionShape2D

var direction: Vector2
var DEF = 0

var max_health = 7
var health = 0
var dead = false
var player_entered : bool
var damage_reduction_factor = 1.0

func _ready():
	
	#$PlayerHit/CollisionShape2D.disabled = true
	health = max_health
	set_physics_process(true)

func _process(_delta):
	
	if not player or dead:
		return
	
	direction = player.position - position

	if direction.x < 0:
		sprite.flip_h = true
		collision_shape.position.x = abs(collision_shape.position.x) * -1
	else:
		sprite.flip_h = false
		collision_shape.position.x = abs(collision_shape.position.x)
	

	
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
	find_child("2FiniteStateMachine").change_state("DeathSkeleton")
	# Add any additional death handling here, e.g., animations, effects, etc.

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player and not dead:
		take_damage(0.8)

func _on_player_hit_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(0.5)


func _on_player_entered_right_area_entered(area):
	if area.get_parent() is Player:
		print("Player entered the area, enabling collision shape")
		player_entered = true
		$PlayerHit/CollisionShape2D.disabled = false

