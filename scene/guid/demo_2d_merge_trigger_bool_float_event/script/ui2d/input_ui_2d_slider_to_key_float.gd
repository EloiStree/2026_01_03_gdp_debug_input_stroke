class_name InputUiSliderToKeyFloatEvent
extends Node

signal on_float_event_submitted(key_name:String, float_value:float)

@export var _slider:Slider
@export var _key_name:String = "unknown_slider_key"

func _ready() -> void:
	if _slider != null:
		_slider.connect("value_changed", _on_slider_value_changed)

func _on_slider_value_changed(value:float) -> void:
	on_float_event_submitted.emit(_key_name, value)

func push_value_with_inspector_key(value:float) -> void:
	if _key_name != "":
		on_float_event_submitted.emit(_key_name, value)
