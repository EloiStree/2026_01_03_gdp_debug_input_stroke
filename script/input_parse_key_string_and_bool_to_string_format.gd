class_name InputParseKeyStringAndBoolToStringFormat
extends Node




signal on_key_bool_parsed_to_string(value: String)


@export var _format_string: String = "%s %s"
@export var _debug_labels:Array[Label]

func push_in_key_string_and_bool(key_string: String, is_on: bool) -> void:
	var bool_as_string = str(is_on)
	var formatted_string = _format_string % [key_string, bool_as_string]
	on_key_bool_parsed_to_string.emit(formatted_string)

	for l in _debug_labels:
		if l:
			l.text = formatted_string
