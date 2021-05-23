extends Node

var clock = 0

func _process(delta):
	clock += 1
	var pos1 = Vector2(cos(clock/2),cos(clock/2))
	var pos2 = Vector2(cos(clock),cos(clock))
	var pos3 = Vector2(cos(clock)*-3,cos(clock)*-3)
	get_node("PULSE_1").set_position(pos1)
	get_node("PULSE_2").set_position(pos2)
	get_node("PULSE_3").set_position(pos3)
