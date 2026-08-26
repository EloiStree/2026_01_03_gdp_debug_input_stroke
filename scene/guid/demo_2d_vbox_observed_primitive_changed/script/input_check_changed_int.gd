class_name InputCheckChangedInt
extends Node


signal on_value_updated(new_value: int)
signal on_value_changed(new_value: int)
signal on_value_changed_with_previous(new_value: int, previous_value: int)

@export var _start_value: int = 0

@export_group("Debug")
@export var _use_print_debug_on_changed: bool = false
@export var _last_received_current: int = 0
@export var _last_received_previous: int = 0

func _ready() -> void:
	_last_received_current = _start_value
	_last_received_previous = _start_value


func push_in_current_value_from_string(value: String) -> void:
	if value.is_valid_int():
		push_in_current_value_from_integer(int(value))

func push_in_current_value_from_float(value: float) -> void:
	push_in_current_value_from_integer(int(value))
	

func push_in_current_value_from_integer(value: int) -> void:
	var previous: int = _last_received_current
	var current: int = value

	_last_received_previous = previous
	_last_received_current = current

	if previous != current:
		on_value_changed.emit(current)
		on_value_changed_with_previous.emit(current, previous)
		if _use_print_debug_on_changed:
			print("Value changed from ", previous, " to ", current)
	on_value_updated.emit(current)
