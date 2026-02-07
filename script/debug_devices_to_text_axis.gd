class_name DebugDevicesToTextAxis extends Node
@export var ui_text_node: Label = null
@export var devise_id_name:="Xbox"
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")

func set_text_for_axis(joy_id: int, label_name: String, value_axis_11: float) -> void:
	ui_text_node.text = "%s %d: %s is %.2f" % [devise_id_name,joy_id + 1, label_name, value_axis_11]
