extends Node2D
func _process(delta):
	$Rotation_Points.rotation_degrees +=1
	$Spinning_Blades_1.global_position = $Rotation_Points/Marker2D.global_position
	$Spinning_Blades_2.global_position =$Rotation_Points/Marker2D2.global_position
	$Spinning_Blades_3.global_position= $Rotation_Points/Marker2D4.global_position
	$Spinning_Blades_4.global_position= $Rotation_Points/Marker2D5.global_position
	$Spinning_Blades_5.global_position= $Rotation_Points/Marker2D6.global_position
	$Spinning_Blades_6.global_position= $Rotation_Points/Marker2D7.global_position
