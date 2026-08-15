class_name  InputUiValueChangedFromLineEdit
extends InputUiValueChangedAbstractVariant

signal on_value_changed_with_previous_value(new_value:String, previous_value:String)
signal on_value_changed(new_value:String)
signal on_value_changed_debug_text(debug_text:String)

@export var _target:LineEdit
@export var _current_value:String = ""
@export var _previous_value:String = ""

@export var _debug_formatted_text: String = "Current Value: %s, Previous Value: %s"
@export var _last_change_as_debug_text: String 
func _ready() -> void:
	if _target==null:
		self.name = "UNASSIGNED TARGET "
		return
	_target.text_changed.connect(_on_value_changed)


func _on_value_changed(new_value:String) -> void:
	_previous_value = _current_value
	_current_value = new_value
	if _current_value != _previous_value:
		on_value_changed_with_previous_value.emit(_current_value, _previous_value)
		on_value_changed.emit(_current_value)
		_notify_change_as_variant(_previous_value, _current_value)
		var text = _debug_formatted_text % [_current_value, _previous_value]
		on_value_changed_debug_text.emit(text)
		_last_change_as_debug_text = text
