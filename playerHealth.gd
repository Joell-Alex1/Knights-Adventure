extends Control
@onready var red_base = $RedBase
@onready var green_fill = $RedBase/GreenFill
@onready var fill_max = green_fill.size.x
@onready var health_percentage = $HealthPercentage

var fill_amount : float

func update_healthbar(health, max_health):
	fill_amount = (float(health) / max_health) * fill_max
	green_fill.size.x = fill_amount
	var percentage = int((health / float(max_health)) * 100)
	health_percentage.text = str(percentage) + "% "
	
