extends CharacterBody2D

class_name FlyEnemy


const speed = 30.0
var dir : Vector2
var Player : CharacterBody2D
var is_bat_chase : bool

var health=4
var max_health=4
var dead = false
var taking_damage = false
var is_roaming :bool

var damage_to_deal = 1

func _ready():
	is_bat_chase=true
	$BatDamageZone/CollisionShape2D.disabled=false
func _process(delta):
	GameM.BatdamageAmt = damage_to_deal
	GameM.BatdamageZone=$BatDamageZone
	if GameM.playerAlive:
		is_roaming = true
	elif !GameM.playerAlive:
		is_roaming = false
		
	if is_on_floor() and dead:
		await get_tree().create_timer(1.5).timeout
		self.queue_free()
			
	move(delta)
	handle_animation()

func move(delta):
	Player = GameM.player
	if !dead:
		is_roaming = true
		if !taking_damage and is_bat_chase and GameM.playerAlive:
			velocity = position.direction_to(Player.position) * speed
			dir.x = abs(velocity.x)/velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(Player.position)*-50
			velocity = knockback_dir
		else:
			velocity += speed*delta*dir

	move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time = choose([1.0,1.5])
	if !is_bat_chase:
		dir = choose([Vector2.DOWN,Vector2.UP,Vector2.LEFT,Vector2.RIGHT])
		
func handle_animation():
	if !dead and !taking_damage:
		$AnimationPlayer.play("idle")
		
		if dir.x == -1:
			$Sprite2D.flip_h = false
			$BatDamageZone.scale.x=1
			$BatHitbox.scale.x=1
			$HealthBar.scale.x=-1
		elif dir.x == 1:
			$BatDamageZone.scale.x=-1
			$BatHitbox.scale.x=-1
			$Sprite2D.flip_h = true
			$HealthBar.scale.x=1
			
	elif !dead and taking_damage:
		$BatDamageZone/CollisionShape2D.disabled=true
		$AnimationPlayer.play("hit")
		$BatDamageZone/CollisionShape2D.disabled=false
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
		
	elif dead and is_roaming:
		$AnimationPlayer.play("die")
		await get_tree().create_timer(1).timeout
		queue_free()

func choose(array):
	array.shuffle()
	return array.front()

func take_damage(damage_amount):
	health -= damage_amount
	taking_damage=true
	
	get_node("HealthBar").update_healthbar(health, max_health)
	if health <= 0:
		$BatDamageZone/CollisionShape2D.disabled=true
		health = 0
		dead = true

func _on_bat_hitbox_area_entered(area):
	if area == GameM.playerDamageZone:
		take_damage(1)
		
func _on_bat_damage_zone_area_entered(area):
	if area.get_parent() is Player and GameM.DamageDealt:
		area.get_parent().take_damage(0.5)




