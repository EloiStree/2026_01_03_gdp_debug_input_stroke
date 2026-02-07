
class_name ListenToFourXbox extends Node

signal on_xbox_is_connected_changed(gamepad_index:int, value_is_connected:bool)
signal on_xbox_index_button_on_off(gamepad_index:int,label_name:String, value_is_down:bool)
signal on_xbox_index_axis_changed(gamepad_index:int,label_name:String, value_axis_11:float)
signal on_xbox_index_vector2_changed(gamepad_index:int,label_name:String, value_joystick:Vector2)

@export var label_stick_left:= "stick_left" # For Vector2
@export var label_stick_right:= "stick_right" # For Vector2

@export var label_trigger_left:= "trigger_left"
@export var label_trigger_right:= "trigger_right"

@export var label_stick_left_horizontal:= "stick_left_horizontal"
@export var label_stick_right_horizontal:= "stick_right_horizontal"

@export var label_stick_left_vertical:= "stick_left_vertical"
@export var label_stick_right_vertical:= "stick_right_vertical" 


@export var label_button_a:= "button_a"
@export var label_button_b:= "button_b"
@export var label_button_x:= "button_x"
@export var label_button_y:= "button_y"

@export var label_button_menu_left:= "button_menu_left"
@export var label_button_menu_right:= "button_menu_right"
@export var label_button_left_side:= "button_left_side"
@export var label_button_right_side:= "button_right_side"
@export var label_button_joystick_left:= "button_joystick_left"
@export var label_button_joystick_right:= "button_joystick_right"

@export var label_arrow_up:= "arrow_up"
@export var label_arrow_down:= "arrow_down"
@export var label_arrow_left:= "arrow_left"
@export var label_arrow_right:= "arrow_right"


var xbox_state_1 := XboxValueState.new()
var xbox_state_2 := XboxValueState.new()
var xbox_state_3 := XboxValueState.new()
var xbox_state_4 := XboxValueState.new()

class XboxValueState:
	var is_connected: bool = false
	var stick_left: Vector2 = Vector2.ZERO
	var stick_right: Vector2 = Vector2.ZERO
	var trigger_left: float = 0.0
	var trigger_right: float = 0.0
	var stick_left_horizontal: float = 0.0
	var stick_left_vertical: float = 0.0
	var stick_right_horizontal: float = 0.0
	var stick_right_vertical: float = 0.0
	var button_a: bool = false
	var button_b: bool = false
	var button_x: bool = false
	var button_y: bool = false
	var button_menu_left: bool = false
	var button_menu_right: bool = false
	var button_left_side: bool = false
	var button_right_side: bool = false
	var button_joystick_left: bool = false
	var button_joystick_right: bool = false
	var arrow_up: bool = false
	var arrow_down: bool = false
	var arrow_left: bool = false
	var arrow_right: bool = false

func _get_state(joy_id: int) -> XboxValueState:
	match joy_id:
		0: return xbox_state_1
		1: return xbox_state_2
		2: return xbox_state_3
		3: return xbox_state_4
		_: return xbox_state_1

func _get_button_index_from_label(label: String) -> int:
	match label:
		label_button_a: return JOY_BUTTON_A
		label_button_b: return JOY_BUTTON_B
		label_button_x: return JOY_BUTTON_X
		label_button_y: return JOY_BUTTON_Y
		label_button_menu_left: return JOY_BUTTON_BACK
		label_button_menu_right: return JOY_BUTTON_START
		label_button_joystick_left: return JOY_BUTTON_LEFT_STICK
		label_button_joystick_right: return JOY_BUTTON_RIGHT_STICK
		label_arrow_up: return JOY_BUTTON_DPAD_UP
		label_arrow_down: return JOY_BUTTON_DPAD_DOWN
		label_arrow_left: return JOY_BUTTON_DPAD_LEFT
		label_arrow_right: return JOY_BUTTON_DPAD_RIGHT
		label_button_left_side: return JOY_BUTTON_RIGHT_SHOULDER
		label_button_right_side: return JOY_BUTTON_LEFT_SHOULDER
		_: return -1

func _get_axis_index_from_label(label: String) -> int:
	match label:
		label_trigger_left: return JOY_AXIS_TRIGGER_LEFT
		label_trigger_right: return JOY_AXIS_TRIGGER_RIGHT
		label_stick_left_horizontal: return JOY_AXIS_LEFT_X
		label_stick_left_vertical: return JOY_AXIS_LEFT_Y
		label_stick_right_horizontal: return JOY_AXIS_RIGHT_X
		label_stick_right_vertical: return JOY_AXIS_RIGHT_Y
		_: return -1

func _get_button_state(state: XboxValueState, label: String) -> bool:
	match label:
		label_button_a: return state.button_a
		label_button_b: return state.button_b
		label_button_x: return state.button_x
		label_button_y: return state.button_y
		label_button_menu_left: return state.button_menu_left
		label_button_menu_right: return state.button_menu_right
		label_button_left_side: return state.button_left_side
		label_button_right_side: return state.button_right_side
		label_button_joystick_left: return state.button_joystick_left
		label_button_joystick_right: return state.button_joystick_right
		label_arrow_up: return state.arrow_up
		label_arrow_down: return state.arrow_down
		label_arrow_left: return state.arrow_left
		label_arrow_right: return state.arrow_right
		_: return false

func _set_button_state(state: XboxValueState, label: String, value: bool) -> void:
	match label:
		label_button_a: state.button_a = value
		label_button_b: state.button_b = value
		label_button_x: state.button_x = value
		label_button_y: state.button_y = value
		label_button_menu_left: state.button_menu_left = value
		label_button_menu_right: state.button_menu_right = value
		label_button_left_side: state.button_left_side = value
		label_button_right_side: state.button_right_side = value
		label_button_joystick_left: state.button_joystick_left = value
		label_button_joystick_right: state.button_joystick_right = value
		label_arrow_up: state.arrow_up = value
		label_arrow_down: state.arrow_down = value
		label_arrow_left: state.arrow_left = value
		label_arrow_right: state.arrow_right = value

func _get_axis_state(state: XboxValueState, label: String) -> float:
	match label:
		label_trigger_left: return state.trigger_left
		label_trigger_right: return state.trigger_right
		label_stick_left_horizontal: return state.stick_left_horizontal
		label_stick_left_vertical: return state.stick_left_vertical
		label_stick_right_horizontal: return state.stick_right_horizontal
		label_stick_right_vertical: return state.stick_right_vertical
		_: return 0.0

func _set_axis_state(state: XboxValueState, label: String, value: float) -> void:
	match label:
		label_trigger_left: state.trigger_left = value
		label_trigger_right: state.trigger_right = value
		label_stick_left_horizontal: state.stick_left_horizontal = value
		label_stick_left_vertical: state.stick_left_vertical = value
		label_stick_right_horizontal: state.stick_right_horizontal = value
		label_stick_right_vertical: state.stick_right_vertical = value

func _get_joystick_vector2(joy_id: int, label: String) -> Vector2:
	match label:
		label_stick_left:
			var x := Input.get_joy_axis(joy_id, JOY_AXIS_LEFT_X)
			var y := -Input.get_joy_axis(joy_id, JOY_AXIS_LEFT_Y)
			return Vector2(x, y)
		label_stick_right:
			var x := Input.get_joy_axis(joy_id, JOY_AXIS_RIGHT_X)
			var y := -Input.get_joy_axis(joy_id, JOY_AXIS_RIGHT_Y)
			return Vector2(x, y)
		_: return Vector2.ZERO

func _get_vector2_state(state: XboxValueState, label: String) -> Vector2:
	match label:
		label_stick_left: return state.stick_left
		label_stick_right: return state.stick_right
		_: return Vector2.ZERO

func _set_vector2_state(state: XboxValueState, label: String, value: Vector2) -> void:
	match label:
		label_stick_left: state.stick_left = value
		label_stick_right: state.stick_right = value




const JOYSTICK_DEADZONE := 0.3


var button_list_from_labels := []
var axis_list_from_labels := []
var vector2_list_from_labels := []

func _ready() -> void:
	button_list_from_labels = [
		label_button_a,
		label_button_b,
		label_button_x,
		label_button_y,
		label_button_menu_left,
		label_button_menu_right,
		label_button_left_side,
		label_button_right_side,
		label_button_joystick_left,
		label_button_joystick_right,
		label_arrow_up,
		label_arrow_down,
		label_arrow_left,
		label_arrow_right
	]
	axis_list_from_labels = [
		label_trigger_left,
		label_trigger_right,
		label_stick_left_horizontal,
		label_stick_left_vertical,
		label_stick_right_horizontal,
		label_stick_right_vertical
	]
	vector2_list_from_labels = [
		label_stick_left,
		label_stick_right
	]



func _process(_delta):
	for joy_id in Input.get_connected_joypads():
		read_controller(joy_id)

func read_controller(joy_id: int) -> void:
	var state := _get_state(joy_id)

	# --- CONNECTION ---
	var is_connected := Input.is_joy_known(joy_id)
	if state.is_connected != is_connected:
		state.is_connected = is_connected
		emit_signal("on_xbox_is_connected_changed", joy_id, is_connected)

	if not is_connected:
		# Reset to zero
		state.stick_left = Vector2.ZERO
		state.stick_right = Vector2.ZERO
		state.trigger_left = 0.0
		state.trigger_right = 0.0
		state.stick_left_horizontal = 0.0
		state.stick_left_vertical = 0.0
		state.stick_right_horizontal = 0.0
		state.stick_right_vertical = 0.0
		state.button_a = false
		state.button_b = false
		state.button_x = false
		state.button_y = false
		state.button_menu_left = false
		state.button_menu_right = false
		state.button_left_side = false
		state.button_right_side = false
		state.button_joystick_left = false
		state.button_joystick_right = false
		state.arrow_up = false
		state.arrow_down = false
		state.arrow_left = false
		state.arrow_right = false
		on_xbox_index_axis_changed.emit(joy_id, label_trigger_left, 0.0)
		on_xbox_index_axis_changed.emit(joy_id, label_trigger_right, 0.0)
		on_xbox_index_axis_changed.emit(joy_id, label_stick_left_horizontal, 0.0)
		on_xbox_index_axis_changed.emit(joy_id, label_stick_left_vertical, 0.0)
		on_xbox_index_axis_changed.emit(joy_id, label_stick_right_horizontal, 0.0)
		on_xbox_index_axis_changed.emit(joy_id, label_stick_right_vertical, 0.0)
		on_xbox_index_vector2_changed.emit(joy_id, label_stick_left, Vector2.ZERO)
		on_xbox_index_vector2_changed.emit(joy_id, label_stick_right, Vector2.ZERO)
		on_xbox_index_button_on_off.emit(joy_id, label_button_a, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_b, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_x, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_y, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_menu_left, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_menu_right, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_left_side, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_right_side, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_joystick_left, false)
		on_xbox_index_button_on_off.emit(joy_id, label_button_joystick_right, false)
		on_xbox_index_button_on_off.emit(joy_id, label_arrow_up, false)
		on_xbox_index_button_on_off.emit(joy_id, label_arrow_down, false)
		on_xbox_index_button_on_off.emit(joy_id, label_arrow_left, false)
		on_xbox_index_button_on_off.emit(joy_id, label_arrow_right, false)
		return

	for label in button_list_from_labels:
		var button_index := _get_button_index_from_label(label)
		if button_index != -1:
			var temp := Input.is_joy_button_pressed(joy_id, button_index)
			if _get_button_state(state, label) != temp:
				_set_button_state(state, label, temp)
				emit_signal("on_xbox_index_button_on_off", joy_id, label, temp)

	for label in axis_list_from_labels:
		var axis_index := _get_axis_index_from_label(label)
		if axis_index != -1:
			var temp_axis := Input.get_joy_axis(joy_id, axis_index)
			if JOY_AXIS_LEFT_Y == axis_index or JOY_AXIS_RIGHT_Y == axis_index:
				temp_axis = -temp_axis
			if _get_axis_state(state, label) != temp_axis:
				_set_axis_state(state, label, temp_axis)
				emit_signal("on_xbox_index_axis_changed", joy_id, label, temp_axis)

	for label in vector2_list_from_labels:
		var temp_vector2 := _get_joystick_vector2(joy_id, label)
		if _get_vector2_state(state, label) != temp_vector2:
			_set_vector2_state(state, label, temp_vector2)
			emit_signal("on_xbox_index_vector2_changed", joy_id, label, temp_vector2)
