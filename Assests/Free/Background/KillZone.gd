extends CollisionShape2D
@onready var timer = $"../Timer"
var player: Player


func _on_kill_zone_body_entered(body):
	GameM.respawn_player()
	Engine.time_scale=0.5
	#body.get_node("CollisionShape2d").queue_free()
	timer.start()

func _on_timer_timeout():
	#get_tree().reload_current_scene()
	Engine.time_scale=1
