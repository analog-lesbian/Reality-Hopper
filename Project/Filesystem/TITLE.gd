extends Node
var begin = false
var turn = 0


func _process(delta):
	turn += 1
	if Input.is_action_just_pressed("start") && begin == false:
		get_node("INTRO").seek(5)
		get_node("/root/GLOBAL/DRAW_TOP_PRIORITY").scene_change("res://Filesystem/STAGE/STAGE1.tscn",2)
		begin = true
	if (begin == true):
		get_node("TEXT_FLASH").play("SELECT")
	else: get_node("TEXT_FLASH").play("FLICKER")
	get_node("CAM_SPIN").play("SPIN")
