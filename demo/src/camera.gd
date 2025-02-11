extends Camera3D

var rmb_down := false
var zoom := 4.0
var rotate_origin = Vector3(0,2,0)
var sensitivity := Vector2(0.001, 0.001)

func _ready() -> void:
	set_process_input(true)
	global_position = rotate_origin + zoom * global_basis.z

func _input(ev: InputEvent) -> void:
	if ev is InputEventMouseButton:
		match ev.button_index:
			MOUSE_BUTTON_RIGHT:
				rmb_down = ev.pressed
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if rmb_down else Input.MOUSE_MODE_VISIBLE
			MOUSE_BUTTON_WHEEL_UP:
				zoom = max(zoom-0.1, 0.1)
			MOUSE_BUTTON_WHEEL_DOWN:
				zoom = min(zoom+0.1, 10.0)
	
	# camera rotation
	if rmb_down and ev is InputEventMouseMotion:
		rotation.y -= ev.relative.x * sensitivity.x
		rotation.x -= ev.relative.y * sensitivity.y
		rotation.x = clamp(rotation.x, -PI/2.0 + 0.001, PI/2.0 + 0.001)
	
	if ev is InputEventMouse:
		# camera offset
		global_position = rotate_origin + zoom * global_basis.z

