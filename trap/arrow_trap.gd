extends Node2D
var arrow_speed = 200.0
@onready var arrow = $Arrow

func _process(delta):
	arrow.translate(Vector2.LEFT*arrow_speed*delta)

func _on_arrow_end_area_entered(area):
	if area == arrow:
		arrow.global_position =$SpawnPoint/Marker2D.global_position 


func _on_arrow_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(3)
