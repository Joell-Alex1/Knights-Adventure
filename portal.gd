extends Node2D

const  file_name = "res://Levels/Level_"

func _on_start_game_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().reset_health()
		print("player health after :" , area.get_parent().health)
		var current_scene_file= get_tree().current_scene.scene_file_path
		var next_level_number=current_scene_file.to_int()+1
		var next_path_level=file_name +str(next_level_number)+ ".tscn"
		Transition.transition()
		await Transition.on_transition_finished
		
		get_tree().change_scene_to_file(next_path_level)
			
			#Transition.transition()
			#await Transition.on_transition_finished
			##await get_tree().create_timer(0.5).timeout
			#get_tree().change_scene_to_file("res://Levels/Level_3.tscn")
