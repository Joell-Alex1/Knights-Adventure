extends Node2D
@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer
signal on_transition_finished

func _ready():
	color_rect.visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Fade_To_Black":
		on_transition_finished.emit()
		animation_player.play("Fade_To_Normal")
		
	elif anim_name=="Fade_To_Normal":
		color_rect.visible= false

	
func transition():
	color_rect.visible = true
	animation_player.play("Fade_To_Black")
	
