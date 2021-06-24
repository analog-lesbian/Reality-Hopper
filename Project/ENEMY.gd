extends KinematicBody

func _process(delta):
	pass

func hurt_player(body):
	if body.name == "PLAYER": body.damaged()

func _stomped(body):
	if body.name == "PLAYER":
		print("Well, Fuck!")
		#play a "hurt" animation
		#spawn an explosion particle
		#delete object
