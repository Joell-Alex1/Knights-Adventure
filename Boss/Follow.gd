extends State
 
func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle")
 
func exit():
	super.exit()
	owner.set_physics_process(false)
 
func transition():
	var distance = owner.direction.length()
	var chance = randi() % 3  # Generates a random number between 0 and 2
	match chance:
		0:
			get_parent().change_state("MeleeAttack")
		1:
			get_parent().change_state("HomingMissile")
		2:
			get_parent().change_state("LaserBeam")

