class_name PlayerPawn extends RigidBody3D

@export var aim_speed = 0.0075
@export var jump_force = 80.0
@export var jump_interval = 500 # msec

var action_jump: bool = false;
var action_rotate: float = 0;
var jump_cooldown_until_time: float = 0;
var is_contacting: bool = true;
var confined: bool = false;
var confinement_pos: Vector3 = Vector3.ZERO;

static var active_player: PlayerPawn

func _ready() -> void:
	active_player = self
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Physics
	set_contact_monitor(true)
	max_contacts_reported = 10
	continuous_cd = true
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
func _exit_tree():
	disconnect("body_entered", _on_body_entered)
	disconnect("body_exited", _on_body_exited)

func _physics_process(delta: float) -> void:
	if action_rotate != 0:
		$Camera.rotate($Camera.quaternion * Vector3.FORWARD, action_rotate * 2. * delta)
	
	if action_jump:
		var jump_dir = $Camera.quaternion * Vector3.FORWARD;
		apply_central_impulse(jump_dir * jump_force);
		jump_cooldown_until_time = Time.get_ticks_msec() + jump_interval
		$AudioStreamPlayer3D.play()
		action_jump = false
		
	if confined:
		position = lerp(position, confinement_pos, delta)
		#$Camera.transform.basis = $Camera.transform.basis.slerp(confinement_rot, delta)

func _on_body_entered (body: Node):
	if !is_contacting:
		linear_velocity = Vector3.ZERO
		is_contacting = true

func _on_body_exited (body: Node):
	is_contacting = false

func _input(event):
	if event.is_action_pressed("interact"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event.is_action_pressed("mouse_capture"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		$Camera.rotate($Camera.quaternion * Vector3.LEFT, event.relative.y * aim_speed)
		$Camera.rotate($Camera.quaternion * Vector3.UP, -event.relative.x * aim_speed)
	
	if event.is_action_pressed("camera_rotate_cw"):
		action_rotate = 1
	elif event.is_action_pressed("camera_rotate_ccw"):
		action_rotate = -1
		
	if event.is_action_released("camera_rotate_cw") || event.is_action_released("camera_rotate_ccw"):
		action_rotate = 0
	
	if event.is_action("jump") && is_jump_allowed():
		action_jump = true

func _process(delta: float) -> void:
	pass
	
func is_jump_allowed() -> bool:
	return !confined && (is_contacting || linear_velocity.length_squared() < 0.01) && jump_cooldown_until_time < Time.get_ticks_msec()
	
func set_confinement_target(pos: Vector3) -> void:
	confined = true
	confinement_pos = pos;
	linear_velocity = Vector3.ZERO

func release_confinement():
	confined = false
	confinement_pos = Vector3.ZERO
