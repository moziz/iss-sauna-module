extends RigidBody3D

var aim_speed = 0.0075
var jump_force = 80.0

var action_jump: bool = false;

func _init() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass

func _physics_process(delta: float) -> void:
	if action_jump:
		var jump_dir = $Camera.quaternion * Vector3.FORWARD;
		apply_central_impulse(jump_dir * jump_force);
		action_jump = false
	pass
	
func _input(event):
	if event.is_action_pressed("mouse_capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		$Camera.rotate($Camera.quaternion * Vector3.LEFT, event.relative.y * aim_speed)
		$Camera.rotate($Camera.quaternion * Vector3.UP, -event.relative.x * aim_speed)
		
	if event.is_action("jump"):
		action_jump = true

func _process(delta: float) -> void:
	pass
