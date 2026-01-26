extends Control

var level_scenes = {
	"Level0": "res://Levels/Level_0.tscn",
	"Level1": "res://Levels/Level_1.tscn",
	"Level2": "res://Levels/Level_2.tscn",
	"Level3": "res://Levels/Level_3.tscn",
	"Level4": "res://Levels/Level_4.tscn",
	"Level5": "res://Levels/Level_5.tscn",
	"Level6": "res://Levels/Level_6.tscn"
}

func load_level(button_name):
	var scene_path = level_scenes[button_name]
	if scene_path:
		get_tree().change_scene_to_file(scene_path)

func _on_level_0_pressed():
	load_level("Level0")


func _on_level_1_pressed():
	load_level("Level1")


func _on_level_2_pressed():
	load_level("Level2")


func _on_level_3_pressed():
	load_level("Level3")


func _on_level_4_pressed():
	load_level("Level4")


func _on_level_5_pressed():
	load_level("Level5")


func _on_level_6_pressed():
	load_level("Level6")


func _on_touch_screen_button_0_pressed():
	load_level("Level0")


func _on_touch_screen_button_1_pressed():
	load_level("Level1")


func _on_touch_screen_button_2_pressed():
	load_level("Level2")


func _on_touch_screen_button_3_pressed():
	load_level("Level3")


func _on_touch_screen_button_4_pressed():
	load_level("Level4")


func _on_touch_screen_button_5_pressed():
	load_level("Level5")



func _on_touch_screen_button_6_pressed():
	load_level("Level6")


func _on_touch_screen_button_pressed():
	if Input.is_action_just_pressed("Back"):
		get_tree().change_scene_to_file("res://main_menu.tscn")
		
