extends StaticBody3D

@export var animationNode: Node 

func Interact(id: int):
	$AudioStreamPlayer3D.play()
	animationNode.Play()
