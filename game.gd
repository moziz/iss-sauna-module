extends Node3D


func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
