class_name  InputUiValueChangedFromButtonDownUp
extends Node

signal on_value_changed_with_previous_value(new_value:bool, previous_value:bool)
signal on_value_changed(new_value:bool)
signal on_value_changed_debug_text(debug_text:String)

@export var _target:BaseButton
@export var _current_value:bool = false
@export var _previous_value:bool = false

@export var _debug_formatted_text: String = "Current Value: %s, Previous Value: %s"
@export var _last_change_as_debug_text: String 
func _ready() -> void:
	if _target==null:
		self.name = "UNASSIGNED TARGET"
		return
	_target.button_down.connect(_on_value_changed_to_true)
	_target.button_up.connect(_on_value_changed_to_false)



func _on_value_changed_to_true() -> void:
	_previous_value = _current_value
	_current_value = true
	if _current_value != _previous_value:
		on_value_changed_with_previous_value.emit(_current_value, _previous_value)
		on_value_changed.emit(_current_value)
		var text = _debug_formatted_text % [_current_value, _previous_value]
		on_value_changed_debug_text.emit(text)
		_last_change_as_debug_text = text

func _on_value_changed_to_false() -> void:
	_previous_value = _current_value
	_current_value = false
	if _current_value != _previous_value:
		on_value_changed_with_previous_value.emit(_current_value, _previous_value)
		on_value_changed.emit(_current_value)
		var text = _debug_formatted_text % [_current_value, _previous_value]
		on_value_changed_debug_text.emit(text)
		_last_change_as_debug_text = text
