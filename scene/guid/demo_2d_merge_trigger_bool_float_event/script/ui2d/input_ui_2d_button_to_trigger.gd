class_name InputUiButtonToTriggerEvent
extends Node

signal on_triggered_event_submitted(trigger_name:String)

@export var _buttons:Array[Button] = []
@export var _trigger_name:String = "unknown_trigger"

func _ready() -> void:
	for button in _buttons:
		if button != null:
			button.connect("pressed", _on_button_pressed)

func _on_button_pressed() -> void:
	on_triggered_event_submitted.emit(_trigger_name)

func push_trigger_with_inspector_key() -> void:
	if _trigger_name != "":
		on_triggered_event_submitted.emit(_trigger_name)
