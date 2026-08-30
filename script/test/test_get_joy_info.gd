class_name TestGetJoyInfo
extends Node

@export var _use_debug_print:bool = false

func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	await get_tree().create_timer(2).timeout
	#print("=== Connected Controllers ===")
	#list_controllers()


func _on_joy_connection_changed(device: int, connected: bool) -> void:
	if connected:
		if _use_debug_print:
			print("\nJoy connected: ", device, " - ", Input.get_joy_name(device), " - GUID: ", Input.get_joy_guid(device))
	else:
		if _use_debug_print:
			print("\nController disconnected!")
	print_controller(device)


# func list_controllers() -> void:
# 	var devices := Input.get_connected_joypads()

# 	if devices.is_empty():
# 		print("No controllers connected.")
# 		return

# 	for device in devices:
# 		print_controller(device)


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

	# print("\nButtons:")
	# for button in _joy_button_list:
	# 	var button_name := _get_button_name(button)
	# 	var pressed := Input.is_joy_button_pressed(device, button)
	# 	print("  ", button_name, " (", button, "): ", "PRESSED" if pressed else "released")

	# print("\nAxes:")
	# for axis in _joy_axis_list:
	# 	var axis_name := _get_axis_name(axis)
	# 	var value := Input.get_joy_axis(device, axis)
	# 	print("  ", axis_name, " (", axis, "): ", "%.3f" % value)

	# print("----------------------------------------")


func _get_button_name(button: JoyButton) -> String:
	match button:
		JOY_BUTTON_A:
			return "A"
		JOY_BUTTON_B:
			return "B"
		JOY_BUTTON_X:
			return "X"
		JOY_BUTTON_Y:
			return "Y"
		JOY_BUTTON_LEFT_SHOULDER:
			return "Left Shoulder"
		JOY_BUTTON_RIGHT_SHOULDER:
			return "Right Shoulder"
		JOY_BUTTON_BACK:
			return "Back"
		JOY_BUTTON_START:
			return "Start"
		JOY_BUTTON_LEFT_STICK:
			return "Left Stick"
		JOY_BUTTON_RIGHT_STICK:
			return "Right Stick"
		JOY_BUTTON_DPAD_DOWN:
			return "D-Pad Down"
		JOY_BUTTON_DPAD_LEFT:
			return "D-Pad Left"
		JOY_BUTTON_DPAD_RIGHT:
			return "D-Pad Right"
		JOY_BUTTON_DPAD_UP:
			return "D-Pad Up"
		_:
			return "Unknown Button"


func _get_axis_name(axis: JoyAxis) -> String:
	match axis:
		JOY_AXIS_LEFT_X:
			return "Left Stick X"
		JOY_AXIS_LEFT_Y:
			return "Left Stick Y"
		JOY_AXIS_RIGHT_X:
			return "Right Stick X"
		JOY_AXIS_RIGHT_Y:
			return "Right Stick Y"
		JOY_AXIS_TRIGGER_LEFT:
			return "Left Trigger"
		JOY_AXIS_TRIGGER_RIGHT:
			return "Right Trigger"
		_:
			return "Unknown Axis"


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
	
