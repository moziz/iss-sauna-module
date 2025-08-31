extends Node3D

@export var rotateAxix: Vector3 
@export var speed: float 
var angle = 0;

func _process(delta: float) -> void:
	self.basis = self.basis.rotated(rotateAxix.normalized(), speed * delta)
