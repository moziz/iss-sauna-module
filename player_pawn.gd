extends RigidBody3D

var aim_speed = 0.0075;

func _init() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func _input(event):
	if event is InputEventMouseMotion:
		$Camera.rotate($Camera.quaternion * Vector3.LEFT, event.relative.y * aim_speed)
		$Camera.rotate($Camera.quaternion * Vector3.UP, -event.relative.x * aim_speed)

func _process(delta: float) -> void:
	pass
