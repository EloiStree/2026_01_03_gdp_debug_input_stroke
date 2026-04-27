class_name DebugDevicesToTextButtons extends Node
@export var ui_text_node: Label = null
@export var devise_id_name:="Xbox"
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")

func set_text_for_button(joy_id: int, gamepad_index: int, label_name: String, value_is_down: bool) -> void:
	ui_text_node.text = "%s %d (gamepad %d): %s is %s" % [devise_id_name, joy_id + 1, gamepad_index, label_name, "down" if value_is_down else "up"]
