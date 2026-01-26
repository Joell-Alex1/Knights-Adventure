extends State1
func enter():
	super.enter()
	await get_tree().create_timer(1.3).timeout
	
	$"../../Attacking/CollisionShape2D/AnimationPlayer".play("On")
	$"../../Attacking/CollisionShape2D2/AnimationPlayer".play("On")
	
	$"../../AnimationPlayer".play("melee_attack")
	
 
func transition():
	if owner.direction.length() > 40 and !$"../..".dead:
		#$"../../AnimationPlayer".play("running")
		get_parent().change_state("Follow")
	elif owner.direction.length() < 40 and !$"../..".dead  :
		$"../../AnimationPlayer".play("melee_attack")
		
	else:
		$"../../AnimationPlayer".play("death")
		
