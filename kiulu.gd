extends Node

@export var animationNode: Node 

func Interact(id: int):
	print("kiulu")
	animationNode.Play()
	$AudioStreamPlayer3D.play()
