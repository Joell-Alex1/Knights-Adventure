extends Node


func _on_end_of_games_area_entered(area):
	if area.get_parent() is Player:
		await get_tree().create_timer(2.0).timeout 
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://main_menu.tscn")
