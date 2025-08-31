extends StaticBody3D

func Interact(id: int):
	var parentti = get_parent_node_3d()
	if id == 3:
		parentti.rotate_y(-PI/2)
	elif id == 5:
		parentti.rotate_y(PI/2)
	elif id == 10:
		parentti.rotate_y(-PI/2)
	else:
		print("Unknown id: ", id)
	
	$AudioStreamPlayer3D.play()
