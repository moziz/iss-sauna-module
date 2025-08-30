extends RigidBody3D

var aim_speed = 0.0075
var jump_force = 80.0
var jump_interval = 500 # msec

var action_jump: bool = false;
var jump_cooldown_until_time: float = 0;

var is_resting: bool = true;

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Physics
	set_contact_monitor(true)
	max_contacts_reported = 10
	continuous_cd = true
	connect("body_entered", on_body_entered)
	connect("body_exited", on_body_exited)
	
func _exit_tree():
	disconnect("body_entered", on_body_entered)
	disconnect("body_exited", on_body_exited)

func _physics_process(delta: float) -> void:
	if action_jump:
		var jump_dir = $Camera.quaternion * Vector3.FORWARD;
		apply_central_impulse(jump_dir * jump_force);
		action_jump = false
		jump_cooldown_until_time = Time.get_ticks_msec() + jump_interval

func on_body_entered (body: Node):
	if !is_resting:
		linear_velocity = Vector3.ZERO
		is_resting = true

func on_body_exited (body: Node):
	is_resting = false

func _input(event):
	if event.is_action_pressed("mouse_capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		$Camera.rotate($Camera.quaternion * Vector3.LEFT, event.relative.y * aim_speed)
		$Camera.rotate($Camera.quaternion * Vector3.UP, -event.relative.x * aim_speed)
	
	if event.is_action("jump") && is_resting && jump_cooldown_until_time < Time.get_ticks_msec():
		action_jump = true

func _process(delta: float) -> void:
	pass
