class_name InputListenToKeyboardOsCtrlAltShift
extends Node


signal on_os_ctrl_alt_shift_changed(os:bool,ctrl:bool,alt:bool,shift:bool)
signal on_os_key_changed(is_on: bool)
signal on_control_changed(is_on: bool)
signal on_alt_changed(is_on: bool)
signal on_shift_changed(is_on: bool)



@export_group("Unfinish")
@export var _use_print_debug: bool = true
@export_group("Debug")
@export var _last_input_found_as_string: String
@export var _last_input_received_raw_as_string: String
@export var _last_input_received_cleaned_as_string: String

@export var _is_shift_present:bool
@export var _is_alt_present:bool
@export var _is_control_present:bool
@export var _is_system_key_present:bool

@export var _shift_label:String  = "shift"
@export var _alt_label:String  = "alt"
@export var _control_label:String  = "ctrl"
@export var _system_label:Array[String]  = ["window","command","super","meta"]

func _input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
				
		var typed := event.as_text()
		var typed_lower := typed.replace("+"," ").to_lower()

		
		_last_input_received_raw_as_string = typed
		var cleaning_text = typed_lower.replace("+"," ").replace(_shift_label,"").replace(_alt_label,"").replace(_control_label,"")
		for label in _system_label:
			cleaning_text = cleaning_text.replace(label,"")
		_last_input_received_cleaned_as_string = cleaning_text

		var is_shift_there:bool= typed_lower.find(_shift_label)==0
		var is_alt_there:bool= typed_lower.find(_alt_label)==0
		var is_control_there:bool= typed_lower.find(_control_label)==0
		var is_system_there:bool = false
		for label in _system_label:
			if typed_lower.find(label) == 0:
				is_system_there = true
				break

		if _use_print_debug:
			print("Typed: ", typed)
		if typed.is_empty():
			return
				
		_last_input_received_cleaned_as_string = _last_input_received_cleaned_as_string.strip_edges()
		
