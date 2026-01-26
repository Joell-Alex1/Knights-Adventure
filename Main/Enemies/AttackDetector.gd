extends Area2D

@onready var player = get_parent().find_child("Player_1")

func _on_area_entered(area):
	if area.get_parent() is Player :
		area.get_parent().take_damage(1)
		queue_free()
