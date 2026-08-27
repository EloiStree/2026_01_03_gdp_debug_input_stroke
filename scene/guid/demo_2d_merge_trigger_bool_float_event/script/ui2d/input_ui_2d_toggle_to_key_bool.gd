class_name InputUiToggleToKeyBoolEvent
extends Node

signal on_bool_event_submitted(key_name:String, bool_value:bool)

@export var _toggle:CheckButton
@export var _key_name:String = "unknown_toggle_key"

func _ready() -> void:
	if _toggle != null:
		_toggle.connect("toggled", _on_toggle_toggled)

func _on_toggle_toggled(pressed:bool) -> void:
	on_bool_event_submitted.emit(_key_name, pressed)


func push_value_with_inspector_key(pressed:bool) -> void:
	if _key_name != "":
		on_bool_event_submitted.emit(_key_name, pressed)

func set_key_name(key_name:String):
	_key_name=key_name
