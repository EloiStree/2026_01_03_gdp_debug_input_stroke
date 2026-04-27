class_name DebugKeyboardToTextKeyIdWithLabel extends Node


@export var ui_text_node: Label = null
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")

func set_text_for_key_id_with_label(key_id: int, label_name: String, is_pressed: bool) -> void:
	ui_text_node.text = "Key ID %d (%s) is %s" % [key_id, label_name, "pressed" if is_pressed else "released"]
