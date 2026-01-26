extends StaticBody2D


func _ready():
	show()

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		hide()
		$AnimationPlayer.play("Fadein")
		queue_free()
