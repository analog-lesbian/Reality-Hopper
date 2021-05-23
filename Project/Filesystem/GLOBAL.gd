extends Node
var wins = 1
onready var dtp = get_node("DRAW_TOP_PRIORITY")

func _physics_process(_delta):
		if (wins != 4):
			OS.window_fullscreen = false
			OS.set_window_size(Vector2(426*wins,240*wins))
			if Input.is_action_just_pressed("debug1"): wins += 1
		else:
			OS.window_fullscreen = true
			if Input.is_action_just_pressed("debug1"): wins = 1
