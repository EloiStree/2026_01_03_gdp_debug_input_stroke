class_name DebugFourXboxToTextIsConnected extends Node

@export var ui_text_node: Label = null
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")
		return

func set_text_for_connected(joy_id: int, is_connected: bool) -> void:
	ui_text_node.text = "Xbox %d is %s" % [joy_id + 1, "connected" if is_connected else "disconnected"]
