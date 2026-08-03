class_name InputParsePrimitiveToString
extends Node


signal on_string_parsed(value: String)

@export var _format_string: String = "%s"



func push_in_variant(value: Variant) -> void:
	var string_value = str(value)
	var formatted_string = _format_string % string_value
	on_string_parsed.emit(formatted_string)


func push_in_primitive_int(value: int) -> void:
	push_in_variant(value)

func push_in_primitive_float(value: float) -> void:
	push_in_variant(value)

func push_in_primitive_string(value: String) -> void:
	push_in_variant(value)

func push_in_primitive_bool(value: bool) -> void:
	push_in_variant(value)
