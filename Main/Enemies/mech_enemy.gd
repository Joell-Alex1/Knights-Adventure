extends CharacterBody2D
var SPEED = 60
var health
var max_health=9
var dead = false
var taking_damage = false
var Player : CharacterBody2D
var facing_right=false
var direction = 1
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

func _ready():
	Player=GameM.player
	$AnimatedSprite2D2.visible=false
	$AttackArea/CollisionShape2D.disabled=false
	health = max_health
	
	
func _process(delta):
	if ray_cast_right.is_colliding():
		direction= -1
		$AnimatedSprite2D.flip_h=true
	if ray_cast_left.is_colliding():
		direction= 1
		$AnimatedSprite2D.flip_h=false
	position.x +=direction*SPEED*delta
	if is_on_floor() and dead:
		await get_tree().create_timer(1.5).timeout
		self.queue_free()
	
	
	

func _physics_process(delta):
	if dead:
		return
	
	handle_animation()
	

func handle_animation():
	if !dead and !taking_damage:
		$AnimatedSprite2D.play("Move")

			
func take_damage(damage_amount):
	health -= damage_amount
	print(health)
	$AnimationPlayer.play("hurt")
	taking_damage=true
	get_node("HealthBar").update_healthbar(health, max_health)
	$AttackArea/CollisionShape2D.disabled=true
	await get_tree().create_timer(1).timeout
	$AttackArea/CollisionShape2D.disabled=false
	if health <= 0:
		$AttackArea/CollisionShape2D.disabled=true
		health = 0
		dead = true
		die()
func die():
	dead = true
	SPEED=0
	$AnimatedSprite2D.visible=false
	$AnimatedSprite2D2.visible=true
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D2.play("Explosion")
	await get_tree().create_timer(1.2).timeout
	self.queue_free()




func _on_hitbox_area_entered(area):
	if area== GameM.playerDamageZone:
		take_damage(1)


func _on_attack_area_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(3)



