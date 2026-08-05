class_name InputParseKeyValueVariantToStringFormat
extends Node

signal on_key_value_variant_to_string_format(text: String)

@export var _format_string: String = "Key: {key}, Value: {value}"


func push_in_key_value(key: Variant, value: Variant, format_string: String) -> void:
	var text: String = format_string.format({
		"key": key,
		"value": value
	})
	on_key_value_variant_to_string_format.emit(text)

func push_in_int_int(key: int, value: int) -> void:
	push_in_key_value(key, value, _format_string)

func push_in_string_bool(key: String, value: bool) -> void:
	push_in_key_value(key, value, _format_string)
	
