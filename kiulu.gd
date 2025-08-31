extends Node

@export var animationNode: Node 

func Interact(id: int):
	var smoke = $"../../Smoke"
	smoke.restart()
	smoke.emitting = true
	print("kiulu")
	animationNode.Play()
	$AudioStreamPlayer3D.play()
