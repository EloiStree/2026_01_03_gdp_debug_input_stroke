class_name DebugDeviceIdNameToLabel extends Node

@export var ui_text_node: Label = null

func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")


func set_text_from_string(device_id:int, text_given:String) -> void:
	ui_text_node.text = "Device %d: %s" % [device_id, text_given]
