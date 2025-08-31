extends StaticBody3D

func Interact(id: int):
	var parentti = get_parent_node_3d()
	if id == 11:
		parentti.rotate_y(-PI/2)
	elif id == 13:
		parentti.rotate_y(PI/2)
	else:
		print("Unknown interaction id", id)
