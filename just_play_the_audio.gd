extends StaticBody3D

func _ready() -> void:
	var clothes = $"../netclothes"
	clothes.visible = false

func Interact(id: int):
	$AudioStreamPlayer3D.play()
	var clothes = $"../netclothes"
	clothes.visible = true
