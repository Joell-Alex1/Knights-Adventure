extends State
 
@onready var pivot = $"../../Pivot"
var can_transition: bool = false


func enter():
	super.enter()
	await play_animation("laser_cast")
	await play_animation("laser")
	can_transition = true
 
func play_animation(anim_name):
	animation_player.play(anim_name)
	await animation_player.animation_finished
 
func set_target():
	pivot.rotation = (owner.direction - pivot.position).angle()
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
func hits():
	$"../../Pivot/AttackDetector".monitoring = true

func _on_attack_area_area_entered(area):
	if area.get_parent() is Player :
		area.get_parent().take_damage(1.5)
		
	
func end_of_hits():
	$"../../Pivot/AttackDetector".monitoring = false



