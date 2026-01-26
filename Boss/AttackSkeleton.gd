extends State2
func enter():
	super.enter()
	$"../../AnimationPlayer".play("attack")
 
 
func transition():
	if owner.direction.length() >25:
		get_parent().change_state("Follow")





