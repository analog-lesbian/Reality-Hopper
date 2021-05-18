# thank you to "Game Endeavor" for sharing his code!!
extends CanvasLayer

signal transition()

onready var ANIM = get_node("ANIM")
onready var FADE_TRANS = get_node("FADE_TRANS")

func scene_change(path,delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	ANIM.play("FADE_2")
	yield(ANIM,"animation_finished")
	assert(get_tree().change_scene(path) == OK)
	ANIM.play_backwards("FADE_2")
	emit_signal("transition")
