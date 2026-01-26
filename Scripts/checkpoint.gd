extends Node2D
class_name Checkpoint

@export var spawnpoint = false
var activated = false
var player = null

func _ready():
	player = get_tree().root.get_node("Main/Player")
	if spawnpoint:
		activate()

func activate():
	GameM.current_checkpoint = self
	activated = true
	

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player and not activated:
		print("player entered")
		activate()

func _process(delta):
	if player and not activated:
		
		activate()
		player.global_position = self.global_position  # Move the player to the checkpoint position
