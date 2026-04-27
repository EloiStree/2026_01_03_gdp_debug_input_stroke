class_name DebugDevicesToTextIsConnected extends Node

@export var ui_text_node: Label = null
@export var devise_id_name:="Xbox"
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")
		return

func set_text_for_connected(joy_id: int, gamepad_index: int, is_connected: bool) -> void:
	ui_text_node.text = "%s %d (gamepad %d) is %s" % [devise_id_name, joy_id + 1, gamepad_index, "connected" if is_connected else "disconnected"]
