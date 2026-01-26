extends Control
func _on_play_button_pressed():
	GameM.start_game()
	queue_free()

func _on_exit_button_pressed():
	GameM.exit_game()


func _on_option_button_pressed():
	pass
	


func _on_play_game_pressed():
	GameM.start_game()
	queue_free()


func _on_exit_game_pressed():
	GameM.exit_game()
