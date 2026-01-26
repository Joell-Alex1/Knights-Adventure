extends State1
func enter():
	super.enter()
	#$Hitbox/CollisionShape2D3/AnimationPlayer.play("On")
	#$Hitbox/CollisionShape2D2/AnimationPlayer.play("On")
	$"../../AnimationPlayer".play("melee_attack")
	
 
func transition():
	if owner.direction.length() > 30:
		get_parent().change_state("Follow")
