extends State2

 
func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	$"../../AnimationPlayer".play("Boss_dead")
