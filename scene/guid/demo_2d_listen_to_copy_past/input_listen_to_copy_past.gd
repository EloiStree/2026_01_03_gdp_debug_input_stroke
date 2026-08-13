class_name InputListenToCopyPast
extends Node


signal on_copy_past_key_value_on_off(key_name:String, is_on: bool)
signal on_copy_past_pressed_name_as_string(value_as_string:String)

signal on_copy_pressed()
signal on_copy_pressed_changed(is_pressing: bool)
signal on_past_pressed()
signal on_past_pressed_changed(is_pressing: bool)
signal on_cut_pressed()
signal on_cut_pressed_changed(is_pressing: bool)
@export var use_print_debug: bool = true
@export var _input_name_cut: String = "ui_cut"
@export var _input_name_copy: String = "ui_copy"
@export var _input_name_past: String = "ui_paste"

@export_group("Debug")
@export var _emitted_text_when_copy: String = "DEVICE_COPY"
@export var _emitted_text_when_past: String = "DEVICE_PAST"
@export var _emitted_text_when_cut: String = "DEVICE_CUT"


@export_group("Debug")
@export var is_copy_pressing: bool
@export var is_past_pressing: bool
@export var is_cut_pressing: bool
@export var is_undo_pressing: bool
@export var is_redo_pressing: bool
@export var is_select_all_pressing: bool


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event := event as InputEventKey
		if key_event.is_pressed() and not key_event.echo:
			if key_event.is_action_pressed(_input_name_copy):
				is_copy_pressing = true
				if use_print_debug:
					print("Copy pressed")
				on_copy_pressed.emit()
				on_copy_pressed_changed.emit(true)
				on_copy_past_key_value_on_off.emit(_emitted_text_when_copy, true)
				on_copy_past_pressed_name_as_string.emit(_emitted_text_when_copy)
			elif key_event.is_action_pressed(_input_name_past):
				is_past_pressing = true
				if use_print_debug:
					print("Past pressed")
				on_past_pressed.emit()
				on_past_pressed_changed.emit(true)
				on_copy_past_key_value_on_off.emit(_emitted_text_when_past, true)
				on_copy_past_pressed_name_as_string.emit(_emitted_text_when_past)
			elif key_event.is_action_pressed(_input_name_cut):
				is_cut_pressing = true
				if use_print_debug:
					print("Cut pressed")
				on_cut_pressed.emit()
				on_cut_pressed_changed.emit(true)
				on_copy_past_key_value_on_off.emit(_emitted_text_when_cut, true)
				on_copy_past_pressed_name_as_string.emit(_emitted_text_when_cut)
		elif key_event.is_action_released(_input_name_copy):
			is_copy_pressing = false
			if use_print_debug:
				print("Copy released")
			on_copy_pressed_changed.emit(false) 
			on_copy_past_key_value_on_off.emit(_emitted_text_when_copy, false)
		elif key_event.is_action_released(_input_name_past):
			is_past_pressing = false
			if use_print_debug:
				print("Past released")
			on_past_pressed_changed.emit(false)
			on_copy_past_key_value_on_off.emit(_emitted_text_when_past, false)
		elif key_event.is_action_released(_input_name_cut):
			is_cut_pressing = false
			if use_print_debug:
				print("Cut released")
			on_cut_pressed_changed.emit(false)
			on_copy_past_key_value_on_off.emit(_emitted_text_when_cut, false)
	
