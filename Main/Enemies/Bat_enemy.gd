extends CharacterBody2D

class_name BatEnemy

const speed = 40.0
var dir : Vector2
var Player : CharacterBody2D
var is_bat_chase : bool

var health = 5
var max_health = 5
var dead = false
var taking_damage = false
var is_roaming : bool

var damage_to_deal = 3

func _ready():
	is_bat_chase = true
	$BatDamageZone/CollisionShape2D.disabled = false
	Player = GameM.player  # Ensure reference to the player is set
	#GameM.connect("player_respawned", self, "_on_player_respawned")
	_on_player_respawned()
func _process(delta):
	GameM.BatdamageAmt = damage_to_deal
	GameM.BatdamageZone = $BatDamageZone

	if GameM.playerAlive:
		is_roaming = true
	else:
		is_roaming = false
		
	if is_on_floor() and dead:
		await get_tree().create_timer(1.5).timeout
		self.queue_free()
			
	move(delta)
	handle_animation()

func move(delta):
	Player = GameM.player  # Update reference to player in each frame
	if !dead:
		is_roaming = true
		if !taking_damage and is_bat_chase and GameM.playerAlive:
			velocity = position.direction_to(Player.position) * speed
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(Player.position) * -50
			velocity = knockback_dir
		else:
			velocity += speed * delta * dir
	else:
		velocity.y += 10 * delta
		velocity.x = 0
	move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time = choose([1.0, 1.5])
	if !is_bat_chase:
		dir = choose([Vector2.DOWN, Vector2.UP, Vector2.LEFT, Vector2.RIGHT])
		
func handle_animation():
	var animated_sprite = $AnimatedSprite2D
	if !dead and !taking_damage:
		animated_sprite.play("flying")
		
		if dir.x == -1:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
	elif taking_damage:
		$AnimatedSprite2D.play("hurt")
		await get_tree().create_timer(0.8).timeout
		taking_damage = false
	elif dead:
		is_roaming = false
		$AnimatedSprite2D.play("death")

func choose(array):
	array.shuffle()
	return array.front()

func take_damage(damage_amount):
	health -= damage_amount
	taking_damage = true
	
	get_node("HealthBar").update_healthbar(health, max_health)
	if health <= 0:
		$BatDamageZone/CollisionShape2D.disabled = true
		health = 0
		dead = true

func _on_bat_hitbox_area_entered(area):
	if area == GameM.playerDamageZone:
		take_damage(1)
		
func _on_bat_damage_zone_area_entered(area):
	if area.get_parent() is Player and GameM.DamageDealt:
		area.get_parent().take_damage(1.5)

func _on_playerdetection_area_entered(area):
	if area.get_parent() is Player:
		$BatDamageZone/AnimationPlayer.play("On")
func _on_player_respawned():
	if not dead:
		$BatDamageZone/CollisionShape2D.disabled = false
		Player = GameM.player
