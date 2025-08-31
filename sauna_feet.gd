extends StaticBody3D

func Interact(id: int):
	PlayerPawn.active_player.set_confinement_target(
		global_position + global_basis * Vector3(0, 1.5, 0)
	)
