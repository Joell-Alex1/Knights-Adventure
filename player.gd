extends CharacterBody2D


func _physics_process(delta):
	velocity = Input.get_vector("left","right","up","ui_down")*250
	move_and_slide()
