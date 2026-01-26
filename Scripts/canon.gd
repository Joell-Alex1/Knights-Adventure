extends StaticBody2D


var cannon_ball= load("res://Main/Scenes/cannon_ball.tscn")
var debris = load("res://Main/Scenes/cannon_debris.tscn")

@export var shooting : bool
var firerate = 2

@onready var firepoint = $Firepoint
var max_health= 3
var health 

func _ready():
	health = max_health
	shooting = true
	shoot()
	
func shoot():
	while shooting:
		$AnimationPlayer.play("fire")
		await get_tree().create_timer(firerate).timeout
func fire():
	var spawned_ball = cannon_ball.instantiate()
	spawned_ball.direction  = firepoint.scale.x
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)
	
func take_damage(damage_amount):
	health -= damage_amount
	get_node("HealthBar").update_healthbar(health , max_health)
	if health <= 0:
		die()
func die():
	var spawned_debris = debris.instantiate()
	spawned_debris.global_position = position
	spawned_debris.get_child(1).play("Break")
	get_tree().get_root().get_child(1).add_child(spawned_debris)
	spawned_debris.queue_free()
	queue_free()
		



