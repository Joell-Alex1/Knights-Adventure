extends Node2D
var canon_speed = 200.0
@onready var canon = $Canon
@onready var canon_2 = $Canon2
@onready var canon_3 = $Canon3
var dead= false
var max_health= 10
var health 
func _ready():
	health = max_health

func _process(delta):
	if !dead:
		canon.translate(Vector2.UP*canon_speed*delta)
		canon_2.translate(Vector2.RIGHT*canon_speed*delta)
		canon_3.translate(Vector2.LEFT*canon_speed*delta)

func take_damage(damage_amount):
	health -= damage_amount
	get_node("HealthBar").update_healthbar(health , max_health)
	if health <= 0:
		#$".".queue_free()
		die()
		
func die():
	dead=true
	$AnimatedSprite2D.play("dead")
	#$Canon.queue_free()
	#$Canon2.queue_free()
	#$Canon3.queue_free()
	#$SpawnPoint.queue_free()
	await get_tree().create_timer(1).timeout
	self.queue_free()
	
func _on_canon_end_area_entered(area):
	if area == canon and not dead:
		canon.global_position = $SpawnPoint/Marker2D.global_position


func _on_canon_end_2_area_entered(area):
	if area ==canon_2 and not dead:
		canon_2.global_position = $SpawnPoint/Marker2D2.global_position
#
func _on_canon_end_3_area_entered(area):
	if area ==canon_3 and not dead:
		canon_3.global_position =$SpawnPoint/Marker2D3.global_position


func _on_canon_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1.5)


func _on_canon_2_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1.5)


func _on_canon_3_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1.5)
