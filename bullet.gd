extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player_1")

var acceleration: Vector2 = Vector2.ZERO 
var velocity: Vector2 = Vector2.ZERO
 
func _physics_process(delta):
 
	acceleration = (player.position - position).normalized() * 700
 
	velocity += acceleration * delta
	rotation = velocity.angle()
 
	velocity = velocity.limit_length(150)
 
	position += velocity * delta
	


func _on_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(2.8)
		queue_free()  # Destroy the bullet after hitting the player


func _on_body_entered(body):
	if body is TileMap:
		queue_free()
