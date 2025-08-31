extends StaticBody3D

var targetYRotation = 0;

func Interact(id: int):
	#var parentti = get_parent_node_3d()
	if id == 11:
		#parentti.rotate_y(-PI/2)
		targetYRotation = -90
		$AudioStreamPlayer3D.play()
	elif id == 13:
		#parentti.rotate_y(PI/2)
		targetYRotation = 0
		$AudioStreamPlayer3D.play()
	else:
		print("Unknown interaction id", id)
		
func _process(delta: float) -> void:
	var parent = get_parent_node_3d()
	parent.rotation_degrees.y = lerpf(parent.rotation_degrees.y, targetYRotation, delta * 2)
