extends Node2D
class_name State1

@onready var debug = owner.find_child("Debug")
@onready var player = owner.get_parent().find_child("Player_1")
@onready var animation_player = owner.find_child("AnimationPlayer")
@onready var enemy = owner.get_parent().find_child("Stone_Golem")
 
func _ready():
	set_physics_process(false)
 
func enter():
	set_physics_process(true)
 
func exit():
	set_physics_process(false)
 
func transition():
	pass
 
func _physics_process(_delta):
	transition()
	
