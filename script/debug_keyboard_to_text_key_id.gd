class_name DebugKeyboardToTextKeyId extends Node

@export var ui_text_node: Label = null

func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")


func set_text_for_key_id(key_id: int, is_pressed: bool) -> void:
	ui_text_node.text = "Key ID %d is %s" % [key_id, "pressed" if is_pressed else "released"]
