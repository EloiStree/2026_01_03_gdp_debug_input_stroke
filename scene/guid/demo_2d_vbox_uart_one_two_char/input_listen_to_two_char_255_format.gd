class_name InputListenToTwoChar255Format
extends Node

## Maps 1–2 byte UART packets to actions.
## 1 byte:  0–255
## 2 bytes: 0–65,535
##
## Designed for low-CPU parsing on Arduino UART input.

signal on_one_char_format_found(value: int)
signal on_two_char_format_found(left: int, right: int)

signal on_one_char_format_found_as_string(value: String)
signal on_two_char_format_found_as_string(value: String)


@export var _last_one_char_found: String = ""
@export var _last_two_char_found: String = ""


func push_in_text_and_emit_if_good_size(text: String) -> void:
	var value := text.strip_edges()

	match value.length():
		1:
			var char_code := value.unicode_at(0)
			_last_one_char_found = value
			on_one_char_format_found.emit(char_code)
			on_one_char_format_found_as_string.emit(value)

		2:
			_last_two_char_found = value
			on_two_char_format_found.emit(
				value.unicode_at(0),
				value.unicode_at(1)
			)
			on_two_char_format_found_as_string.emit(value)


func push_in_byte_packed_and_emit_if_good_size(
	bytes: PackedByteArray
) -> void:
	match bytes.size():
		1:
			_last_one_char_found = char(bytes[0])
			on_one_char_format_found.emit(bytes[0])
			on_one_char_format_found_as_string.emit(_last_one_char_found)

		2:
			_last_two_char_found = char(bytes[0]) + char(bytes[1])
			on_two_char_format_found.emit(bytes[0], bytes[1])
			on_two_char_format_found_as_string.emit(_last_two_char_found)


func push_in_byte_array_and_emit_if_good_size(
	bytes: Array[int]
) -> void:
	match bytes.size():
		1:
			if _is_valid_byte(bytes[0]):
				_last_one_char_found = char(bytes[0])
				on_one_char_format_found.emit(bytes[0])
				on_one_char_format_found_as_string.emit(_last_one_char_found)

		2:
			if _is_valid_byte(bytes[0]) and _is_valid_byte(bytes[1]):
				_last_two_char_found = char(bytes[0]) + char(bytes[1])
				on_two_char_format_found.emit(bytes[0], bytes[1])
				on_two_char_format_found_as_string.emit(_last_two_char_found)


func _is_valid_byte(value: int) -> bool:
	return value >= 0 and value <= 255
