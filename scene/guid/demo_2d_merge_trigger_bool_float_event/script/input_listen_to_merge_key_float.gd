class_name InputListenToMergeKeyFloatEvent
extends Node


signal on_key_float_event_submitted(key:String, value:float)
signal on_key_float_event_submitted_as_format(debug_text:String)

@export var _last_received_key:String = ""
@export var _last_received_value:float = 0.0
@export var _debug_key_value_format:String = "%s: %.2f"
@export var _debug_labels:Array[Label] = []

func _ready() -> void:
	InputMergeToKeyFloatEvent.add_listener(self._on_key_float_event_submitted)

func _exit_tree() -> void:
	InputMergeToKeyFloatEvent.remove_listener(self._on_key_float_event_submitted)

func _on_key_float_event_submitted(key:String, value:float) -> void:
	_last_received_key = key
	_last_received_value = value
	on_key_float_event_submitted.emit(key, value)
	var debug_text = _debug_key_value_format % [key, value]
	on_key_float_event_submitted_as_format.emit(debug_text)
	for label in _debug_labels:
		if label != null:
			label.text = debug_text

