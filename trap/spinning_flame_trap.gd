extends Node2D
func _process(delta):
	$Rotation_Points.rotation_degrees +=1
	
	$Flame_trap.global_position = $Rotation_Points/Marker2D.global_position
	$Flame_trap2.global_position =$Rotation_Points/Marker2D2.global_position
	$Flame_trap4.global_position= $Rotation_Points/Marker2D4.global_position
	$Flame_trap5.global_position= $Rotation_Points/Marker2D5.global_position
	$Flame_trap6.global_position= $Rotation_Points/Marker2D6.global_position
	$Flame_trap7.global_position= $Rotation_Points/Marker2D7.global_position
