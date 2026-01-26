extends Control

@onready var main_menu_scene = "res://main_menu.tscn"

func _ready():
	hide() # Hide the pause menu initially

func resume():
	get_tree().paused = false
	hide() # Hide the pause menu when resuming the game

func pause():
	get_tree().paused = true
	show() # Show the pause menu when pausing the game

func testEsc():
	if Input.is_action_just_pressed("esc"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed():
	resume()

func _on_quit_pressed():
	resume() # Make sure the game is unpaused before changing the scene
	get_tree().change_scene_to_file("res://level_selection.tscn")

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _process(delta):
	testEsc()


func _on_resume_1_pressed():
	pass # Replace with function body.
