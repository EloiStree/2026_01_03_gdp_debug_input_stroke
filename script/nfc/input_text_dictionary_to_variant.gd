class_name InputTextDictionaryToVariant
extends Node

signal on_text_value_found(Value_found:Variant)
signal on_text_value_found_as_string(Value_found:String)
signal on_text_key_value_found(text_use_as_key:String, value:Variant)
signal on_text_key_not_found(text_use_as_key:String)

@export var _dictionary_text_to_variant:Dictionary[String,String]
@export var _use_debug_log:bool = false
@export var _last_text_used_as_keyreceived:String
@export var _last_found_value:Variant

func emit_if_integer_equals_to_one_key(value:int):
	emit_if_text_equals_to_one_key(str(value))
	
func _notify_found_given_variant(value:Variant):
	on_text_value_found.emit(value)
	on_text_value_found_as_string.emit(str(value))
	if _use_debug_log:
		print("Given value is String: ", value)

func _notify_not_found_key(text:String):
	if _use_debug_log:
		print("Key not found: ", text)
	on_text_key_not_found.emit(text)

func emit_if_text_equals_to_one_key(text:String):
	_last_text_used_as_keyreceived = text
	if _dictionary_text_to_variant.has(text):
		var value:Variant = _dictionary_text_to_variant[text]
		_notify_found_given_variant(value)
	else :
		_notify_not_found_key(text)

func emit_if_text_finishing_by_one_key(text:String):
	_last_text_used_as_keyreceived = text
	
	for key in _dictionary_text_to_variant.keys():
		if text.ends_with(key):
			var value:Variant = _dictionary_text_to_variant[key]
			_notify_found_given_variant(value)
			return
	if _use_debug_log:
		_notify_not_found_key(text)
	_last_found_value = null

func clear_dictionary() -> void:
	_dictionary_text_to_variant.clear()

func remove_from_key_value(key:String) -> void:
	if _dictionary_text_to_variant.has(key):
		_dictionary_text_to_variant.erase(key)

func append_key_value_from_text(text:String, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	var lines = text.split(line_splitter, false)
	for line in lines:
		var key_value = line.split(key_value_splitter, false)
		if key_value.size() == 2:
			var code = key_value[0].strip_edges()
			var value = key_value[1].strip_edges()
			append_key_with_parsed_to_string_value(code, value)
		if key_value.size() == 1:
			var code = key_value[0].strip_edges()
			append_key_with_parsed_to_string_value(code, "")

func append_key_value_from_text_split_by_line_and_dots(text:String):
	append_key_value_from_text(text, ":", "\n")

func append_key_value_from_text_split_by_line_and_diamond(text:String):
	append_key_value_from_text(text, "♦️", "\n")

func append_key_with_variant_value(key:String, value:Variant) -> void:
	_dictionary_text_to_variant[key] = value

func append_key_with_parsed_to_string_value(key:String, value:Variant) -> void:
	_dictionary_text_to_variant[key] = str(value)
