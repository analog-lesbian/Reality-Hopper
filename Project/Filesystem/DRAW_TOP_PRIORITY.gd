extends CanvasLayer

signal scene_changed()

onready var animation_player = get_node("ANIM")

func play_random_animation():
	var animations = animation_player.get_animation_list()
	var animation_id = randi() % animations.size()
	var animation_name = animations[animation_id]
	animation_player.play(animation_name)
	
func play_random_animation_reverse():
	var animations = animation_player.get_animation_list()
	var animation_id = randi() % animations.size()
	var animation_name = animations[animation_id]
	animation_player.play_backwards(animation_name)

func scene_change(path,delay = 0.5):
	
	yield(get_tree().create_timer(delay), "timeout")
	
	play_random_animation()
	
	yield(animation_player, "animation_finished")
	assert(get_tree().reload_current_scene() == OK if (path == "reset") else get_tree().change_scene(path) == OK)
	
	animation_player.stop()
	get_node("TRANS_COVER").show()
	animation_player.seek(0,true)
	
	play_random_animation_reverse()
	get_node("TRANS_COVER").hide()
	
	yield(animation_player, "animation_finished")
	emit_signal("scene_changed")
