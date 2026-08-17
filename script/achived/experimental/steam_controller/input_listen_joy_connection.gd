class_name InputListenToJoyConnection
extends Node


# ============================================================
# READY
# ============================================================

func _ready() -> void:

	Input.joy_connection_changed.connect(
		_on_joy_connection_changed
	)

	print("")
	print("========================================")
	print("       GODOT JOYSTICK DIAGNOSTICS")
	print("========================================")

	list_controllers()


# ============================================================
# CONTROLLER CONNECT / DISCONNECT
# ============================================================

func _on_joy_connection_changed(
	device: int,
	connected: bool
) -> void:

	print("")
	print("========================================")

	if connected:
		print(">>> CONTROLLER CONNECTED <<<")
	else:
		print(">>> CONTROLLER DISCONNECTED <<<")

	print("Device ID: ", device)

	if connected:
		print_controller(device)

	else:
		print("Device was disconnected.")


# ============================================================
# LIST CONTROLLERS
# ============================================================

func list_controllers() -> void:

	var devices := Input.get_connected_joypads()

	print("Connected devices: ", devices.size())
	print("")

	if devices.is_empty():
		print("No controllers detected.")
		return

	for device in devices:

		print_controller(device)


# ============================================================
# PRINT CONTROLLER
# ============================================================

func print_controller(device: int) -> void:

	print("")
	print("----------------------------------------")
	print("CONTROLLER")
	print("----------------------------------------")

	# --------------------------------------------------------
	# Device ID
	# --------------------------------------------------------

	print("Device ID : ", device)


	# --------------------------------------------------------
	# Name
	# --------------------------------------------------------

	var device_name := Input.get_joy_name(device)

	print("Name      : ", device_name)


	# --------------------------------------------------------
	# GUID
	# --------------------------------------------------------

	var guid := Input.get_joy_guid(device)

	print("GUID      : ", guid)


	# --------------------------------------------------------
	# GUID HEX -> ASCII
	#
	# Useful because your Android GUIDs appear to contain
	# ASCII text.
	# --------------------------------------------------------

	print("GUID ASCII: ", _hex_to_ascii(guid))


	# --------------------------------------------------------
	# get_joy_info
	# --------------------------------------------------------

	var info: Dictionary = Input.get_joy_info(device)

	print("")
	print("--- get_joy_info() ---")

	if info.is_empty():

		print("Empty on this platform.")
		print("Platform: Android")

	else:

		for key in info.keys():

			print(
				str(key),
				" = ",
				str(info[key])
			)


	# --------------------------------------------------------
	# BUTTONS
	# --------------------------------------------------------

	print("")
	print("--- BUTTONS ---")

	var found_button := false

	for button in _joy_button_list:

		if Input.is_joy_button_pressed(
			device,
			button
		):

			print(
				"Pressed: ",
				_button_name(button),
				"  ID=",
				button
			)

			found_button = true

	if not found_button:

		print("No buttons currently pressed.")


	# --------------------------------------------------------
	# AXES
	# --------------------------------------------------------

	print("")
	print("--- AXES ---")

	for axis in _joy_axis_list:

		var value := Input.get_joy_axis(
			device,
			axis
		)

		print(
			_axis_name(axis),
			" [",
			axis,
			"] = ",
			"%.4f" % value
		)


	print("----------------------------------------")


# ============================================================
# CONVERT HEX GUID TO ASCII
# ============================================================

func _hex_to_ascii(hex_string: String) -> String:

	if hex_string.length() % 2 != 0:
		return ""

	var result := ""

	for i in range(0, hex_string.length(), 2):

		var byte_string := hex_string.substr(
			i,
			2
		)

		var value := byte_string.hex_to_int()

		if value >= 32 and value <= 126:

			result += char(value)

		else:

			result += "."

	return result


# ============================================================
# BUTTON NAMES
# ============================================================

func _button_name(button: int) -> String:

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
			return "LEFT_SHOULDER"

		JOY_BUTTON_RIGHT_SHOULDER:
			return "RIGHT_SHOULDER"

		JOY_BUTTON_BACK:
			return "BACK"

		JOY_BUTTON_START:
			return "START"

		JOY_BUTTON_LEFT_STICK:
			return "LEFT_STICK"

		JOY_BUTTON_RIGHT_STICK:
			return "RIGHT_STICK"

		JOY_BUTTON_DPAD_UP:
			return "DPAD_UP"

		JOY_BUTTON_DPAD_DOWN:
			return "DPAD_DOWN"

		JOY_BUTTON_DPAD_LEFT:
			return "DPAD_LEFT"

		JOY_BUTTON_DPAD_RIGHT:
			return "DPAD_RIGHT"

		_:
			return "BUTTON_" + str(button)


# ============================================================
# AXIS NAMES
# ============================================================

func _axis_name(axis: int) -> String:

	match axis:

		JOY_AXIS_LEFT_X:
			return "LEFT_X"

		JOY_AXIS_LEFT_Y:
			return "LEFT_Y"

		JOY_AXIS_RIGHT_X:
			return "RIGHT_X"

		JOY_AXIS_RIGHT_Y:
			return "RIGHT_Y"

		JOY_AXIS_TRIGGER_LEFT:
			return "LEFT_TRIGGER"

		JOY_AXIS_TRIGGER_RIGHT:
			return "RIGHT_TRIGGER"

		_:
			return "AXIS_" + str(axis)


# ============================================================
# BUTTON LIST
# ============================================================

var _joy_button_list: Array[int] = [

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

	JOY_BUTTON_DPAD_UP,
	JOY_BUTTON_DPAD_DOWN,
	JOY_BUTTON_DPAD_LEFT,
	JOY_BUTTON_DPAD_RIGHT
]


# ============================================================
# AXIS LIST
# ============================================================

var _joy_axis_list: Array[int] = [

	JOY_AXIS_LEFT_X,
	JOY_AXIS_LEFT_Y,

	JOY_AXIS_RIGHT_X,
	JOY_AXIS_RIGHT_Y,

	JOY_AXIS_TRIGGER_LEFT,
	JOY_AXIS_TRIGGER_RIGHT
]
