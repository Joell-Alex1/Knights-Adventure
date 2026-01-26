extends RigidBody2D


func _on_detection_area_entered(area):
	if area.get_parent() is Player:
		set_deferred("freeze",false)
		$Timer.start()


func _on_timer_timeout():
	queue_free()
