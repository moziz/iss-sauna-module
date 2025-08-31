extends StaticBody3D

var targetYRotation = 0;

func Interact(id: int):
	#var parentti = get_parent_node_3d()
	if id == 3:
		targetYRotation = -90
		#parentti.rotate_y(-PI/2)
	elif id == 5:
		targetYRotation = 0
		#parentti.rotate_y(PI/2)
	elif id == 10:
		targetYRotation = -90
		#parentti.rotate_y(-PI/2)
	else:
		print("Unknown id: ", id)
	
	$AudioStreamPlayer3D.play()
	
func _process(delta: float) -> void:
	var parent = get_parent_node_3d()
	parent.rotation_degrees.y = lerpf(parent.rotation_degrees.y, targetYRotation, delta * 2)
