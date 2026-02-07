class_name DebugFourXboxToTextAxis extends Node
@export var ui_text_node: Label = null
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")

func set_text_for_axis(joy_id: int, label_name: String, value_axis_11: float) -> void:
	ui_text_node.text = "Xbox %d: %s is %.2f" % [joy_id + 1, label_name, value_axis_11]
