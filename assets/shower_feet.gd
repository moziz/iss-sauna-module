extends StaticBody3D

func Interact(id: int):
	if id == 4:
		PlayerPawn.active_player.set_confinement_target(
			global_position + quaternion * Vector3(0, 1.5, 0)
		)
	if id == 9:
		PlayerPawn.active_player.release_confinement()
