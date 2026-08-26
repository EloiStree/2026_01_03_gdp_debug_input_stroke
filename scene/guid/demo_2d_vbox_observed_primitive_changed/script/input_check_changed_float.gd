class_name InputCheckChangedFloat
extends Node


signal on_value_updated(new_value: float)
signal on_value_changed(new_value: float)
signal on_value_changed_with_previous(new_value: float, previous_value: float)

@export var _start_value: float = 0
@export var _use_margin_to_be_considered: bool = true
@export var _margin_value_to_be_considered: float = 0.0001

@export_group("Debug")
@export var _use_print_debug_on_changed: bool = false
@export var _last_received_current: float = 0
@export var _last_received_previous: float = 0

func _ready() -> void:
	_last_received_current = _start_value
	_last_received_previous = _start_value
	
	
func push_in_current_value_from_string(value: String) -> void:
	if value.is_valid_float():
		push_in_current_value_from_float(float(value))

func push_in_current_value_from_integer(value: int) -> void:
	push_in_current_value_from_float(float(value))

func push_in_current_value_from_float(value: float) -> void:
	if _use_margin_to_be_considered:
		if abs(value - _last_received_current) > _margin_value_to_be_considered:
			emit_change_signals(_last_received_current, value)
	else:
		emit_change_signals(_last_received_current, value)
	

func emit_change_signals(previous: float, current: float) -> void:

	_last_received_previous = previous
	_last_received_current = current
	if previous != current:
		on_value_changed.emit(current)
		on_value_changed_with_previous.emit(current, previous)
		if _use_print_debug_on_changed:
			print("Value changed from ", previous, " to ", current)
	on_value_updated.emit(current)
