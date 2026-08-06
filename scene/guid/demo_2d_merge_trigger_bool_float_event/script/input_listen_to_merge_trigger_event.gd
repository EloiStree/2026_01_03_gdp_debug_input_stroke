class_name InputListenToMergeTriggerEvent
extends Node


signal on_trigger_event_submitted(trigger_name:String)
signal on_trigger_event_submitted_as_format(debug_text:String)

@export var _last_received_trigger_name:String = ""
@export var _debug_trigger_format:String = "%s"
@export var _debug_labels:Array[Label] = []

func _ready() -> void:
	InputMergeToTriggerEvent.add_listener(self._on_trigger_event_submitted)

func _exit_tree() -> void:
	InputMergeToTriggerEvent.remove_listener(self._on_trigger_event_submitted)

func _on_trigger_event_submitted(trigger_name:String) -> void:
	_last_received_trigger_name = trigger_name
	on_trigger_event_submitted.emit(trigger_name)
	var debug_text = _debug_trigger_format % [trigger_name]
	on_trigger_event_submitted_as_format.emit(debug_text)
	for label in _debug_labels:
		if label != null:
			label.text = debug_text
