class_name DebugStringToLabel extends Node

@export var ui_text_node: Label = null

func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")


func set_text_from_string(text_given:String) -> void:
	ui_text_node.text = text_given
