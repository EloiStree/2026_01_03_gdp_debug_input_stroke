class_name InputListenToTvRemote
extends Node


signal on_tv_remote_key_value_on_off(key_name:String, is_on: bool)
signal on_tv_remote_pressed_name_as_string(value_as_string:String)
signal on_tv_remote_pressed_int_as_string(key_code:String)
signal on_tv_remote_key_pressed(key_code: int)
signal on_tv_pressed_key_up()
signal on_tv_pressed_key_right()
signal on_tv_pressed_key_down()
signal on_tv_pressed_key_left()
signal on_tv_pressed_key_accept()
signal on_tv_pressed_key_back()

signal on_tv_pressed_key_up_value(is_pressing: bool)
signal on_tv_pressed_key_right_value(is_pressing: bool)
signal on_tv_pressed_key_down_value(is_pressing: bool)
signal on_tv_pressed_key_left_value(is_pressing: bool)
signal on_tv_pressed_key_accept_value(is_pressing: bool)
signal on_tv_pressed_key_back_value(is_pressing: bool)



@export var _input_map_arrow_up: String = "ui_up"
@export var _input_map_arrow_down: String = "ui_down"
@export var _input_map_arrow_left: String = "ui_left"
@export var _input_map_arrow_right: String = "ui_right"
@export var _input_map_enter: String = "ui_accept"
@export var _input_map_back: String = "ui_cancel"

@export var _use_print_debug: bool = false


func _input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		var key_event := event as InputEventKey
		if key_event.is_pressed():
			if Input.is_action_pressed(_input_map_arrow_up):
				if _use_print_debug:
					print("Arrow Up pressed")
				on_tv_remote_key_pressed.emit(KEY_UP)
				on_tv_remote_key_value_on_off.emit("KEY_UP", true)
				on_tv_pressed_key_up.emit()
				on_tv_pressed_key_up_value.emit(true)
				on_tv_remote_pressed_name_as_string.emit("KEY_UP")
				on_tv_remote_pressed_int_as_string.emit(str(KEY_UP))
			elif Input.is_action_pressed(_input_map_arrow_down):
				if _use_print_debug:
					print("Arrow Down pressed")
				on_tv_remote_key_pressed.emit(KEY_DOWN)
				on_tv_remote_key_value_on_off.emit("KEY_DOWN", true)
				on_tv_pressed_key_down.emit()
				on_tv_pressed_key_down_value.emit(true)
				on_tv_remote_pressed_name_as_string.emit("KEY_DOWN")
				on_tv_remote_pressed_int_as_string.emit(str(KEY_DOWN))
			elif Input.is_action_pressed(_input_map_arrow_left):
				if _use_print_debug:
					print("Arrow Left pressed")
				on_tv_remote_key_pressed.emit(KEY_LEFT)
				on_tv_remote_key_value_on_off.emit("KEY_LEFT", true)
				on_tv_pressed_key_left.emit()
				on_tv_pressed_key_left_value.emit(true)
				on_tv_remote_pressed_name_as_string.emit("KEY_LEFT")
				on_tv_remote_pressed_int_as_string.emit(str(KEY_LEFT))
			elif Input.is_action_pressed(_input_map_arrow_right):
				if _use_print_debug:
					print("Arrow Right pressed")
				on_tv_remote_key_pressed.emit(KEY_RIGHT)
				on_tv_remote_key_value_on_off.emit("KEY_RIGHT", true)
				on_tv_pressed_key_right.emit()
				on_tv_pressed_key_right_value.emit(true)
				on_tv_remote_pressed_name_as_string.emit("KEY_RIGHT")
				on_tv_remote_pressed_int_as_string.emit(str(KEY_RIGHT))
			elif Input.is_action_pressed(_input_map_enter):
				if _use_print_debug:
					print("Enter pressed")
				on_tv_remote_key_pressed.emit(KEY_ENTER)
				on_tv_remote_key_value_on_off.emit("KEY_ENTER", true)
				on_tv_pressed_key_accept.emit()
				on_tv_pressed_key_accept_value.emit(true)
				on_tv_remote_pressed_name_as_string.emit("KEY_ENTER")
				on_tv_remote_pressed_int_as_string.emit(str(KEY_ENTER))

			elif Input.is_action_pressed(_input_map_back):
				if _use_print_debug:
					print("Back pressed")
				on_tv_remote_key_pressed.emit(KEY_BACK)
				on_tv_remote_key_value_on_off.emit("KEY_BACK", true)
				on_tv_pressed_key_back.emit()
				on_tv_pressed_key_back_value.emit(true)
				on_tv_remote_pressed_name_as_string.emit("KEY_BACK")
				on_tv_remote_pressed_int_as_string.emit(str(KEY_BACK))
			
		elif key_event.is_released():
			if Input.is_action_just_released(_input_map_arrow_up):
				on_tv_pressed_key_up_value.emit(false)
			elif Input.is_action_just_released(_input_map_arrow_down):
				on_tv_pressed_key_down_value.emit(false)
			elif Input.is_action_just_released(_input_map_arrow_left):
				on_tv_pressed_key_left_value.emit(false)
			elif Input.is_action_just_released(_input_map_arrow_right):
				on_tv_pressed_key_right_value.emit(false)
			elif Input.is_action_just_released(_input_map_enter):
				on_tv_pressed_key_accept_value.emit(false)
			elif Input.is_action_just_released(_input_map_back):
				on_tv_pressed_key_back_value.emit(false)
