extends Node2D


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().max_health +=5
		area.get_parent().health +=5
		var player = area.get_parent()
		player.update_health()
		queue_free()
		
