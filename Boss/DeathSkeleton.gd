extends State2
 
func enter():
	super.enter()
	animation_player.play("death")

	await get_tree().create_timer(1.8).timeout
	queue_free()
