class_name InputListenToKeyboardCharAsAlias
extends Node


signal on_new_input_detected(input_name: String)

@export var _last_found_input: String = ""
@export var _use_print_debug:bool


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
	if _listen_to_key_event and event is InputEventKey:
		if not event.is_echo():
			var key_event := event as InputEventKey
			var key_unicode_int := key_event.unicode
			if key_unicode_int > 0 and key_unicode_int < 256:
				if key_unicode_int == 13:
					notify_as_new_input_keyboard("Enter")
				elif key_unicode_int == 8:
					notify_as_new_input_keyboard("Backspace")
				elif key_unicode_int == 9:
					notify_as_new_input_keyboard("Tab")
				elif key_unicode_int == 27:
					notify_as_new_input_keyboard("Escape")
				elif key_unicode_int == 32:
					return
				else:
					var unicode_char := char(key_unicode_int)
					notify_as_new_input_keyboard(unicode_char)
	
