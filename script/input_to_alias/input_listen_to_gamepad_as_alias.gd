class_name InputListenToGamepadAsAlias
extends Node


signal on_new_input_detected(input_name: String)

@export var _last_found_input: String = ""
@export var _use_print_debug:bool = false


var bool_joystick_left_left = false
var bool_joystick_left_right = false
var bool_joystick_left_up = false
var bool_joystick_left_down = false

var bool_joystick_right_left = false
var bool_joystick_right_right = false
var bool_joystick_right_up = false
var bool_joystick_right_down = false

var bool_trigger_left = false
var bool_trigger_right = false


func notify_as_new_input_keyboard(to_add: String) -> void:
	if _use_print_debug:
		print("Keyboard input detected: ", to_add)
	_last_found_input = to_add
	on_new_input_detected.emit(to_add)

func notify_as_new_input(to_add: String) -> void:
	if _use_print_debug:
		print("Gamepad input detected: ", to_add)
	_last_found_input = to_add
	on_new_input_detected.emit(to_add)
	
@export var _listen_to_key_event:bool=true
func _input(event: InputEvent) -> void:
	
	if event is InputEventJoypadButton and event.pressed:
			var button_index :int= event.button_index
			var to_add := ""
			match button_index:
				JOY_BUTTON_A:
					to_add = "A"
				JOY_BUTTON_B:
					to_add = "B"
				JOY_BUTTON_X:
					to_add = "X"
				JOY_BUTTON_Y:
					to_add = "Y"
				JOY_BUTTON_LEFT_SHOULDER:
					to_add = "L1"
				JOY_BUTTON_RIGHT_SHOULDER:
					to_add = "R1"
				JOY_BUTTON_BACK:
					to_add = "Back"
				JOY_BUTTON_START:
					to_add = "Start"
				JOY_BUTTON_LEFT_STICK:
					to_add = "L3"
				JOY_BUTTON_RIGHT_STICK:
					to_add = "R3"
				JOY_BUTTON_DPAD_DOWN:
					to_add = "DD"
				JOY_BUTTON_DPAD_LEFT:
					to_add = "DL"
				JOY_BUTTON_DPAD_RIGHT:
					to_add = "DR"
				JOY_BUTTON_DPAD_UP:
					to_add = "DU"
				JOY_AXIS_TRIGGER_LEFT:
					to_add = "L2"
				JOY_AXIS_TRIGGER_RIGHT:
					to_add = "R2"
				_:
					to_add= str(button_index)
			notify_as_new_input(to_add)
	
	# Gamepad arrow
	var joy_motion_event := event as InputEventJoypadMotion
	if joy_motion_event != null:
		var axis_value := joy_motion_event.axis_value
		var axis_index := joy_motion_event.axis
		var to_add := ""
		var is_true: bool=false
		var has_changed: bool=false
		if axis_index == JOY_AXIS_LEFT_X: # Left stick horizontal
			is_true = axis_value < -0.5
			has_changed = is_true != bool_joystick_left_left
			if has_changed and is_true:
				to_add = "L←"
			bool_joystick_left_left = is_true
			is_true = axis_value > 0.5
			has_changed = is_true != bool_joystick_left_right
			if has_changed and is_true:
				to_add = "L→"
			bool_joystick_left_right = is_true
		elif axis_index == JOY_AXIS_LEFT_Y: # Left stick vertical
			is_true = axis_value < -0.5
			has_changed = is_true != bool_joystick_left_up
			if has_changed and is_true:
				to_add = "L↑"
			bool_joystick_left_up = is_true
			is_true = axis_value > 0.5
			has_changed = is_true != bool_joystick_left_down
			if has_changed and is_true:
				to_add = "L↓"
			bool_joystick_left_down = is_true
		elif axis_index == JOY_AXIS_RIGHT_X: # Right stick horizontal
			is_true = axis_value < -0.5
			has_changed = is_true != bool_joystick_right_left
			if has_changed and is_true:
				to_add = "R←"
			bool_joystick_right_left = is_true
			is_true = axis_value > 0.5
			has_changed = is_true != bool_joystick_right_right
			if has_changed and is_true:
				to_add = "R→"
			bool_joystick_right_right = is_true
		elif axis_index == JOY_AXIS_RIGHT_Y: # Right stick vertical
			is_true = axis_value < -0.5
			has_changed = is_true != bool_joystick_right_up
			if has_changed and is_true:
				to_add = "R↑"
			bool_joystick_right_up = is_true
			is_true = axis_value > 0.5
			has_changed = is_true != bool_joystick_right_down
			if has_changed and is_true:
				to_add = "R↓"
			bool_joystick_right_down = is_true
		elif axis_index == JOY_AXIS_TRIGGER_LEFT: # Left trigger
			is_true = axis_value > 0.5
			has_changed = is_true != bool_trigger_left
			if has_changed and is_true:
				to_add = "L2"
			bool_trigger_left = is_true
		elif axis_index == JOY_AXIS_TRIGGER_RIGHT: # Right trigger
			is_true =axis_value > 0.5
			has_changed = is_true != bool_trigger_right
			if has_changed and is_true:
				to_add = "R2"
			bool_trigger_right = is_true
		
		if to_add != "":
			notify_as_new_input(to_add)
			
