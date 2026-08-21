class_name InputTranslateTextToTextList
extends Node

signal on_text_value_found(text:String)
signal on_text_key_value_found(code:String, text:String)
signal on_text_key_not_found(code:String)

@export var _text_to_lists_dico_trigger:Dictionary[String,Array] = {}

@export var _ignore_case:bool =true

func try_to_emit_store_text_from_key(code:String) -> void:
	if _text_to_lists_dico_trigger.has(code):
		var text_list = _text_to_lists_dico_trigger[code]
		on_text_key_value_found.emit(code, str(text_list))
		for text in text_list:
			on_text_value_found.emit(text)
	else:
		on_text_key_not_found.emit(code)

func try_to_emit_store_text_from_key_as_integer(code:int) -> void:
	var code_str = str(code)
	try_to_emit_store_text_from_key(code_str)


func has_key(code:String) -> bool:
	return _text_to_lists_dico_trigger.has(code)

func set_key_value(code:String, text:String) -> void:
	_text_to_lists_dico_trigger[code] = [text]

func remove_key(code:String) -> void:
	if _text_to_lists_dico_trigger.has(code):
		_text_to_lists_dico_trigger.erase(code)

func append_key_value(code:String, text:String) -> void:
	if _text_to_lists_dico_trigger.has(code):
		_text_to_lists_dico_trigger[code].append(text)
	else:
		_text_to_lists_dico_trigger[code] = [text]

const line_return_splitter:String = "\n"
const diamond_splitter:String = "♦️"

func set_key_value_from_text_diamond_splitter(text:String) -> void:
	_text_to_lists_dico_trigger.clear()
	append_key_value_from_text(text, diamond_splitter, line_return_splitter)


func set_key_value_from_text(text:String, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	_text_to_lists_dico_trigger.clear()
	append_key_value_from_text(text, key_value_splitter, line_splitter)


func append_key_value_from_text(text:String, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	if _ignore_case:
		text = text.to_lower()
		
	var lines = text.split(line_splitter, false)
	for line in lines:
		var key_value = line.split(key_value_splitter, false)
		if key_value.size() == 2:
			var code = key_value[0].strip_edges()
			var value = key_value[1].strip_edges()
			append_key_value(code, value)
		if key_value.size() == 1:
			var code = key_value[0].strip_edges()
			append_key_value(code, "")
