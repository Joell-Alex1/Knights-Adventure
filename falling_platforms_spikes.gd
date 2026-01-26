extends RigidBody2D


func _on_timer_timeout():
	$Spikes2.queue_free()
	queue_free()



