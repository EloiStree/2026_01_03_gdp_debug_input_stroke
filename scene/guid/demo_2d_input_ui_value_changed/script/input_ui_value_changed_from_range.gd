class_name  InputUiValueChangedFromRange
extends InputUiValueChangedAbstractVariant


signal on_value_changed_with_previous_value(new_value:float, previous_value:float)
signal on_value_changed(new_value:float)
signal on_value_changed_debug_text(debug_text:String)

@export var _target:Range
@export var _current_value:float = 0.0
@export var _previous_value:float = 0.0
@export var _debug_formatted_text: String = "Current Value: %s, Previous Value: %s"
@export var _last_change_as_debug_text: String 


func _ready() -> void:
	if _target==null:
		self.name = "UNASSIGNED TARGET"
		return
	_target.value_changed.connect(_on_value_changed)


func _on_value_changed(value:float) -> void:
	_previous_value = _current_value
	_current_value = value
	if _current_value != _previous_value:
		on_value_changed_with_previous_value.emit(_current_value, _previous_value)
		on_value_changed.emit(_current_value)
		_notify_change_as_variant(_previous_value, _current_value)
		var text = _debug_formatted_text % [_current_value, _previous_value]
		on_value_changed_debug_text.emit(text)
		_last_change_as_debug_text = text
