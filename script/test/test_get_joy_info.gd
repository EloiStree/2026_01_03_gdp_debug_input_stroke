extends Node

func _ready() -> void:
	# Listen for controller connection/disconnection.
	Input.joy_connection_changed.connect(_on_joy_connection_changed)

	print("=== Connected Controllers ===")
	list_controllers()


func _on_joy_connection_changed(device: int, connected: bool) -> void:
	if connected:
		print("\nController connected!")
	else:
		print("\nController disconnected!")

	print_controller(device)


func list_controllers() -> void:
	var devices := Input.get_connected_joypads()

	if devices.is_empty():
		print("No controllers connected.")
		return

	for device in devices:
		print_controller(device)


func print_controller(device: int) -> void:
	print("----------------------------------------")
	print("Device ID: ", device)

	# Basic information
	print("Name: ", Input.get_joy_name(device))
	print("GUID: ", Input.get_joy_guid(device))

	# Extra information
	var info := Input.get_joy_info(device)

	if info.is_empty():
		print("Extra Info: None")
	else:
		print("Extra Info:")
		for key in info.keys():
			print("  ", key, " = ", info[key])

	# Show button states
	print("\nButtons:")
	for button in _joy_button_list:
		if Input.is_joy_button_pressed(device, button):
			print("  Pressed: ", button)

	# Show axis values
	print("\nAxes:")
	for axis in _joy_axis_list:
		var value := Input.get_joy_axis(device, axis)

		# Ignore tiny values caused by stick drift.
		if abs(value) > 0.05:
			print("  ", axis, " = ", value)

	print("----------------------------------------")


var _joy_button_list:Array = [
	JOY_BUTTON_A,
	JOY_BUTTON_B,
	JOY_BUTTON_X,
	JOY_BUTTON_Y,
	JOY_BUTTON_LEFT_SHOULDER,
	JOY_BUTTON_RIGHT_SHOULDER,
	JOY_BUTTON_BACK,
	JOY_BUTTON_START,
	JOY_BUTTON_LEFT_STICK,
	JOY_BUTTON_RIGHT_STICK,
	JOY_BUTTON_DPAD_DOWN,
	JOY_BUTTON_DPAD_LEFT,
	JOY_BUTTON_DPAD_RIGHT,
	JOY_BUTTON_DPAD_UP
]

var _joy_axis_list:Array = [
	JOY_AXIS_LEFT_X,
	JOY_AXIS_LEFT_Y,
	JOY_AXIS_RIGHT_X,
	JOY_AXIS_RIGHT_Y,
	JOY_AXIS_TRIGGER_LEFT,
	JOY_AXIS_TRIGGER_RIGHT
]
