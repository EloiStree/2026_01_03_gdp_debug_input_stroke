class_name InputCheckChangedString
extends Node


signal on_value_updated(new_value: String)
signal on_value_changed(new_value: String)
signal on_value_changed_with_previous(new_value: String, previous_value: String)

@export var _start_value: String = ""

@export_group("Debug")
@export var _use_print_debug_on_changed: bool = false
@export var _last_received_current: String = ""
@export var _last_received_previous: String =  ""

func _ready() -> void:
	_last_received_current = _start_value
	_last_received_previous = _start_value
	

func push_in_current_value(value: String) -> void:
	var previous: String = _last_received_current
	var current: String = value

	_last_received_previous = previous
	_last_received_current = current

	if previous != current:
		on_value_changed.emit(current)
		on_value_changed_with_previous.emit(current, previous)
		if _use_print_debug_on_changed:
			print("Value changed from ", previous, " to ", current)
	on_value_updated.emit(current)
