extends State1

 
func enter():
	super.enter()
	owner.set_physics_process(true)
	$"../../AnimationPlayer".play("running")
 
func exit():
	super.exit()
	owner.set_physics_process(false)
 
func transition():
	var distance = owner.direction.length()
 
	if distance < 40 and !$"../..".dead:
		get_parent().change_state("MeleeAttack")
	elif distance > 40 and !$"../..".dead :
		$"../../AnimationPlayer".play("running")
	else:
		$"../../AnimationPlayer".play("death")
