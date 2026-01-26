extends State

func enter():
	super.enter()
	$"../../Hitbox/CollisionShape2D3/AnimationPlayer".play("On")
	$"../../Hitbox/CollisionShape2D2/AnimationPlayer".play("On")
	animation_player.play("melee_attack")
	
 
func transition():
	$"../../Hitbox/CollisionShape2D3/AnimationPlayer".play("OFF")
	$"../../Hitbox/CollisionShape2D2/AnimationPlayer".play("OFF")
	get_parent().change_state("Follow")
	#var distance = owner.direction.length()
	#var chance = randi() % 2  # Generates a random number between 0 and 2
	#if distance > 30:
		#get_parent().change_state("Dash")
		#
	#match chance:
		#0:
#
			#get_parent().change_state("LaserBeam")
		#1:
			##$"../../Hitbox/CollisionShape2D3/AnimationPlayer".play("OFF")
			##$"../../Hitbox/CollisionShape2D2/AnimationPlayer".play("OFF")
			#get_parent().change_state("HomingMissile")
		##2:
			###$"../../Hitbox/CollisionShape2D3/AnimationPlayer".play("OFF")
			###$"../../Hitbox/CollisionShape2D2/AnimationPlayer".play("OFF")
			##get_parent().change_state("LaserBeam")



