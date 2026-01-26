extends State1
func enter():
	super.enter()
	$"../../Attacking/CollisionShape2D".disabled=true
	$"../../Attacking/CollisionShape2D2".disabled=true
	$"../../AnimationPlayer".play("death")
	await animation_player.animation_finished
	await get_tree().create_timer(1.5).timeout
	queue_free()
	
