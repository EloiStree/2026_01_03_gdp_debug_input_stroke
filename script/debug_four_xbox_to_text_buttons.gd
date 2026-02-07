class_name DebugFourXboxToTextButtons extends Node
@export var ui_text_node: Label = null
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")

func set_text_for_button(joy_id: int, label_name: String, value_is_down: bool) -> void:
	ui_text_node.text = "Xbox %d: %s is %s" % [joy_id + 1, label_name, "down" if value_is_down else "up"]
