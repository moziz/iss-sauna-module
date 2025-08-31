extends Node

@export var rotateAxix: Vector3 
@export var speed: float 


func _process(delta: float) -> void:
	self.quaternion.rotate_object_local(rotateAxix, speed * delta)
