extends Node2D

func _ready():
	$AnimatedSprite2D.play("Spin")

func _on_attack_area_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)
