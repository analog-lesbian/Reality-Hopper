extends Node2D

func _ready():
	get_node("AnimationPlayer").play("INTRO")


func _process(delta):
	if Input.is_action_just_pressed("start"):
		get_node("/root/Global/DRAW_TOP_PRIORITY").scene_change("res://test1.tscn")
