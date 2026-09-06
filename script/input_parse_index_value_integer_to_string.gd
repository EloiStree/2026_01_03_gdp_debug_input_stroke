class_name InputParseIndexValueIntegerToString
extends Node

signal on_string_parsed(value: String)

@export var _format_string_integer: String = "%s"
@export var _format_string_index_integer: String = "%s|%s"
@export var _format_string_integer_date: String = "%s|D%s"
@export var _format_string_index_integer_date: String = "%s|%s|D%s"


func push_in_integer(value: int) -> void:
	var string_value = str(value)
	var formatted_string = _format_string_integer % string_value
	on_string_parsed.emit(formatted_string)

func push_in_index_integer(index:int, value:int) -> void:
	var string_value = str(value)
	var formatted_string = _format_string_index_integer % [str(index), string_value]
	on_string_parsed.emit(formatted_string)
	

func push_in_index_integer_date(index:int, value:int, date:int) -> void:
	var string_value = str(value)
	var formatted_string = _format_string_index_integer_date % [str(index), string_value, date]
	on_string_parsed.emit(formatted_string)

func push_in_integer_date(value:int, date:int) -> void:
	var string_value = str(value)
	var formatted_string = _format_string_integer_date % [string_value, str(date)]
	on_string_parsed.emit(formatted_string)


func push_in_bytes_if_iid_size(bytes_to_display:PackedByteArray) -> void:
	if bytes_to_display.size() == 4:
		var integer_value = bytes_to_display.decode_s32(0)
		push_in_integer(integer_value)
	elif bytes_to_display.size() == 8:
		var index_value = bytes_to_display.decode_s32(0)
		var integer_value = bytes_to_display.decode_s32(4)
		push_in_index_integer(index_value, integer_value)
	elif bytes_to_display.size() == 12:
		var integer_value = bytes_to_display.decode_s32(4)
		var date_value = bytes_to_display.decode_u64(8)
		push_in_integer_date(integer_value, date_value)
	elif bytes_to_display.size() == 16:
		var index_value = bytes_to_display.decode_s32(0)
		var integer_value = bytes_to_display.decode_s32(4)
		var date_value = bytes_to_display.decode_u64(8)
		push_in_index_integer_date(index_value, integer_value, date_value)

		
