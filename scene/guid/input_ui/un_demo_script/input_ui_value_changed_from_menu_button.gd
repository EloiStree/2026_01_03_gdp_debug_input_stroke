class_name  InputUiValueChangedFromMenuButton
extends InputUiValueChangedAbstractVariant

signal on_value_changed_with_previous_value(new_value:int, previous_value:int)
signal on_value_changed(new_value:int)
signal on_value_changed_debug_text(debug_text:String)

@export var _target:MenuButton
@export var _current_value:int = 0
@export var _previous_value:int = 0

@export var _debug_formatted_text: String = "Current Value: %s, Previous Value: %s"
@export var _last_change_as_debug_text: String 
func _ready() -> void:
	if _target==null:
		self.name = "UNASSIGNED TARGET "
		return
	_target.get_popup().id_pressed.connect(_on_value_changed)


func _on_value_changed(new_value:int) -> void:
	_previous_value = _current_value
	_current_value = new_value
	if _current_value != _previous_value:
		on_value_changed_with_previous_value.emit(_current_value, _previous_value)
		on_value_changed.emit(_current_value)
		_notify_change_as_variant(_previous_value, _current_value)
		var text = _debug_formatted_text % [_current_value, _previous_value]
		on_value_changed_debug_text.emit(text)
		_last_change_as_debug_text = text
