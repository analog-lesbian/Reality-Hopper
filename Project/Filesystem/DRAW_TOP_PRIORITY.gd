extends CanvasLayer

signal scene_changed()

onready var animation_player = get_node("ANIM")
onready var FADE_TRANS = get_node("FADE_TRANS")

func scene_change(path,delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("FADE")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("FADE")
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
