extends Node
class_name ListenToNesAsJoystick

signal on_nes_is_connected_changed(joy_id: int, gamepad_index: int, value_is_connected: bool)
signal on_nes_is_name_found(joy_id: int, gamepad_index:int, joy_name:String)
signal on_nes_index_button_on_off(joy_id: int, gamepad_index: int, label_name: String, value_is_down: bool)
signal on_nes_index_button_with_id_on_off(joy_id: int, gamepad_index: int, button_id: int, value_is_down:bool)

const AXIS_THRESHOLD := 0.5

# -------------------------
# Labels
# -------------------------
@export var label_button_a := "button_a"
@export var label_button_b := "button_b"

@export var label_button_menu_left := "button_menu_left"
@export var label_button_menu_right := "button_menu_right"

@export var label_arrow_up := "arrow_up"
@export var label_arrow_down := "arrow_down"
@export var label_arrow_left := "arrow_left"
@export var label_arrow_right := "arrow_right"


@export var button_a_id :Array[int]=[1]
@export var button_b_id :Array[int]=[3]
@export var button_menu_left_id :Array[int]=[JOY_BUTTON_BACK]
@export var button_menu_right_id :Array[int]=[JOY_BUTTON_START]
@export var arrow_up_id :Array[int]=[JOY_BUTTON_DPAD_UP]
@export var arrow_down_id :Array[int]=[JOY_BUTTON_DPAD_DOWN]
@export var arrow_left_id :Array[int]=[JOY_BUTTON_DPAD_LEFT]
@export var arrow_right_id :Array[int]=[JOY_BUTTON_DPAD_RIGHT]

# -------------------------
# State container
# -------------------------
class NesValueState:
	var is_connected := false
	var button_a := false
	var button_b := false
	var button_menu_left := false
	var button_menu_right := false
	var arrow_up := false
	var arrow_down := false
	var arrow_left := false
	var arrow_right := false

# joy_id -> NesValueState
var nes_found_list: Array[NesValueState] = []

var button_list_from_labels: Array[String] = []

# -------------------------
# Lifecycle
# -------------------------
func _ready() -> void:
	button_list_from_labels = [
		label_button_a,
		label_button_b,
		label_button_menu_left,
		label_button_menu_right,
		label_arrow_up,
		label_arrow_down,
		label_arrow_left,
		label_arrow_right
	]

	for device in Input.get_connected_joypads():
		print("Joypad connected:", device)

func _process(_delta: float) -> void:
	for joy_id in Input.get_connected_joypads():
		read_controller(joy_id)


class ButtonToOnOff:
	var button_id: int
	var is_down: bool

	func _init():
		button_id = -1
		is_down = false
	


class DeviceState:
	var is_connected: bool
	var button_id_to_on_off: Array[ButtonToOnOff]

	func _init():
		is_connected = false
		button_id_to_on_off = []
	func get_button_on_off(button_id: int) -> bool:
		for button_to_on_off in button_id_to_on_off:
			if button_to_on_off.button_id == button_id:
				return button_to_on_off.is_down
		return false
	func set_button_on_off(button_id: int, is_down: bool) -> void:
		for button_to_on_off in button_id_to_on_off:
			if button_to_on_off.button_id == button_id:
				button_to_on_off.is_down = is_down
				return
		var new_button_to_on_off := ButtonToOnOff.new()
		new_button_to_on_off.button_id = button_id
		new_button_to_on_off.is_down = is_down
		button_id_to_on_off.append(new_button_to_on_off)

var on_off_buttons_per_device : Array[DeviceState]


func set_nes_button_a_id( joystick_id:int):
	button_a_id = [joystick_id]
	
func set_nes_button_a_ids( joystick_id:Array[int]):
	button_a_id = joystick_id

func set_nes_button_b_id( joystick_id:int):
	button_b_id = [joystick_id]

func set_nes_button_b_ids( joystick_id:Array[int]):
	button_b_id = joystick_id

# menu left 
func set_nes_button_menu_left_id( joystick_id:int):
	button_menu_left_id = [joystick_id]

func set_nes_button_menu_left_ids( joystick_id:Array[int]):
	button_menu_left_id = joystick_id

# menu right
func set_nes_button_menu_right_id( joystick_id:int):
	button_menu_right_id = [joystick_id]

func set_nes_button_menu_right_ids( joystick_id:Array[int]):
	button_menu_right_id = joystick_id

# arrow up
func set_nes_arrow_up_id( joystick_id:int):
	arrow_up_id = [joystick_id]

func set_nes_arrow_up_ids( joystick_id:Array[int]):
	arrow_up_id = joystick_id

# arrow down
func set_nes_arrow_down_id( joystick_id:int):
	arrow_down_id = [joystick_id]

func set_nes_arrow_down_ids( joystick_id:Array[int]):
	arrow_down_id = joystick_id

# arrow left
func set_nes_arrow_left_id( joystick_id:int):
	arrow_left_id = [joystick_id]

func set_nes_arrow_left_ids( joystick_id:Array[int]):
	arrow_left_id = joystick_id

# arrow right
func set_nes_arrow_right_id( joystick_id:int):
	arrow_right_id = [joystick_id]

func set_nes_arrow_right_ids( joystick_id:Array[int]):
	arrow_right_id = joystick_id

@export var xbox_name_keyword :Array[String]=["xinput","xbox"]
func is_xbox_device(name:String)->bool:
	name = name.to_lower()
	for w in xbox_name_keyword:
		var ww = w.to_lower()
		if name.find(ww) != -1:
			return true
	return false



var apparitions_of_joy_id: Array[int] = []
func _get_gamepad_index_from_apparitions_list(joy_id: int) -> int:
	for i in range(apparitions_of_joy_id.size()):
		if apparitions_of_joy_id[i] == joy_id:
			return i
	return -1

# -------------------------
# Core logic
# -------------------------
func read_controller(joy_id: int) -> void:


	# --- CONNECTION ---
	var is_connected := Input.is_joy_known(joy_id)

	var name := Input.get_joy_name(joy_id)
	var is_xbox_controller := is_xbox_device(name)
	if is_xbox_controller:
		return

	if joy_id >= nes_found_list.size():
		nes_found_list.resize(joy_id + 1)
		nes_found_list[joy_id] = NesValueState.new()
	var state := nes_found_list[joy_id]
		
	if not apparitions_of_joy_id.has(joy_id):
		apparitions_of_joy_id.append(joy_id)

	var nes_index := _get_gamepad_index_from_apparitions_list(joy_id)


	if state.is_connected != is_connected:
		state.is_connected = is_connected
		on_nes_is_connected_changed.emit(joy_id, nes_index, is_connected)
		on_nes_is_name_found.emit(joy_id, nes_index, name)

	# Get all the button of the device and check it state compare to before
	# store in an double array the id>button_index bool value for that
	if joy_id >= on_off_buttons_per_device.size():
		on_off_buttons_per_device.resize(joy_id + 1)
		on_off_buttons_per_device[joy_id] = DeviceState.new()


	var device_state := on_off_buttons_per_device[joy_id]
	var number_of_buttons := 32
	for count in range(1, number_of_buttons + 1):
		var button_id := count - 1
		var is_down := Input.is_joy_button_pressed(joy_id, button_id)
		if device_state.get_button_on_off(button_id) != is_down:
			device_state.set_button_on_off(button_id, is_down)
			on_nes_index_button_with_id_on_off.emit(joy_id, nes_index, button_id, is_down)
		



	



	# --- BUTTONS ---
	for label in button_list_from_labels:
		var button_id_list := _get_button_id_list_from_label(label)
		for button_id in button_id_list:
			var is_down := Input.is_joy_button_pressed(joy_id, button_id)
			if _get_button_state(state, label) != is_down:
				_set_button_state(state, label, is_down)
				on_nes_index_button_on_off.emit(joy_id, nes_index, label, is_down)
				on_nes_index_button_with_id_on_off.emit(joy_id, nes_index, button_id, is_down)



func _get_button_id_list_from_label(label: String) -> Array[int]:
	match label:
		label_button_a: return button_a_id
		label_button_b: return button_b_id
		label_button_menu_left: return button_menu_left_id
		label_button_menu_right: return button_menu_right_id
		label_arrow_up: return arrow_up_id
		label_arrow_down: return arrow_down_id
		label_arrow_left: return arrow_left_id
		label_arrow_right: return arrow_right_id
		_: return []

func _get_button_state(state: NesValueState, label: String) -> bool:
	match label:
		label_button_a: return state.button_a
		label_button_b: return state.button_b
		label_button_menu_left: return state.button_menu_left
		label_button_menu_right: return state.button_menu_right
		label_arrow_up: return state.arrow_up
		label_arrow_down: return state.arrow_down
		label_arrow_left: return state.arrow_left
		label_arrow_right: return state.arrow_right
		_: return false

func _set_button_state(state: NesValueState, label: String, value: bool) -> void:
	match label:
		label_button_a: state.button_a = value
		label_button_b: state.button_b = value
		label_button_menu_left: state.button_menu_left = value
		label_button_menu_right: state.button_menu_right = value
		label_arrow_up: state.arrow_up = value
		label_arrow_down: state.arrow_down = value
		label_arrow_left: state.arrow_left = value
		label_arrow_right: state.arrow_right = value
		_: pass
