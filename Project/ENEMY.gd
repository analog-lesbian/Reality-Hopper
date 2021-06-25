extends Spatial

func _ready():
	var parlayer = get_parent().get_collision_layer()
	
	get_node("DEATH_AREA").set_collision_layer_bit(parlayer-1, true)
	get_node("DEATH_AREA").set_collision_mask_bit(parlayer-1, true)
	
	get_node("HURT_AREA").set_collision_layer_bit(parlayer-1, true)
	get_node("HURT_AREA").set_collision_mask_bit(parlayer-1, true)
	
	
func hurt_player(body):
	if body.name == "PLAYER": body.damaged()

func _stomped(body):
	if body.name == "PLAYER":
		print("Well, Fuck!")
		#play a "hurt" animation
		#spawn an explosion particle
		#delete object

#REMEMBER!
#Collision layers determine what objects will detect your collision
#Collision masks determine what you will collide with
