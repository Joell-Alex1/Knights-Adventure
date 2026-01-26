extends State1
@onready var collision = $"../../PlayerDetection/CollisionShape2D"
@onready var progress_bar = owner.find_child("HealthBar")
 
var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible",value)
 
func transition():
	if player_entered:
		get_parent().change_state("Follow")


func _on_player_detection_area_entered(area):
	if area.get_parent() is Player:
		
		player_entered = true
