extends KinematicBody

func _process(delta):
	pass

func _on_Area_body_entered(body):
	queue_free()
	
