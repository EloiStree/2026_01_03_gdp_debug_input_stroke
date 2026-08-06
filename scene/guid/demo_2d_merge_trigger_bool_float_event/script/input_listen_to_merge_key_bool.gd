class_name InputListenToMergeKeyBoolEvent
extends Node


signal on_key_bool_event_submitted(key:String, value:bool)
signal on_key_bool_event_submitted_as_format(debug_text:String)

@export var _last_received_key:String = ""
@export var _last_received_value:bool = false
@export var _debug_key_value_format:String = "%s: %s"

@export var _debug_labels:Array[Label] = []

func _ready() -> void:
	InputMergeToKeyBoolEvent.add_listener(self._on_key_bool_event_submitted)

func _exit_tree() -> void:
	InputMergeToKeyBoolEvent.remove_listener(self._on_key_bool_event_submitted)

func _on_key_bool_event_submitted(key:String, value:bool) -> void:
	_last_received_key = key
	_last_received_value = value
	on_key_bool_event_submitted.emit(key, value)
	var debug_text = _debug_key_value_format % [key, str(value)]
	on_key_bool_event_submitted_as_format.emit(debug_text)
	for label in _debug_labels:
		if label != null:
			label.text = debug_text
	
