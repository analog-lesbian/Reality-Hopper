extends Node
var begin = false

func _process(delta):
	if Input.is_action_just_pressed("start") && begin == false:
		get_node("AnimationPlayer").seek(5)
		get_node("/root/GLOBAL/DRAW_TOP_PRIORITY").scene_change("res://Filesystem/STAGE/STAGE1.tscn",2)
		begin = true
	if (begin == true):
		get_node("AnimationPlayer2").play("SELECT")
	else: get_node("AnimationPlayer2").play("FLICKER")
