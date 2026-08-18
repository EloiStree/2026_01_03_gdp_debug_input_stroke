class_name InputTranslateTextToTextListInOut
extends Node

signal on_text_value_found(text:String)
signal on_text_key_value_found(code:String, text:String)
signal on_text_key_not_found(code:String)

@export var _text_to_lists_dico_enter:Dictionary[String,Array] = {}
@export var _text_to_lists_dico_exit:Dictionary[String,Array] = {}
@export var _ignore_case_for_key:bool=true

@export var _last_emitted_enter:String
@export var _last_emitted_exit:String
@export var _last_not_found_key:String

func _get_dico(is_enter:bool=true) -> Dictionary[String,Array]:
	return _text_to_lists_dico_enter if is_enter else _text_to_lists_dico_exit


func try_to_emit_store_text_from_key_enter_condition(code:String) -> void:
	try_to_emit_store_text_from_key_condition(code, true)

func try_to_emit_store_text_from_key_exit_condition(code:String) -> void:
	try_to_emit_store_text_from_key_condition(code, false)


func try_to_emit_store_text_from_key_condition(code:String, is_enter:bool=true) -> void:
	var dico = _get_dico(is_enter)
	if dico.has(code):
		var text_list = dico[code]
		on_text_key_value_found.emit(code, str(text_list))
		for text in text_list:
			on_text_value_found.emit(text)
			if is_enter:
				_last_emitted_enter=text
			else:
				_last_emitted_exit=text
	else:
		on_text_key_not_found.emit(code)
		_last_not_found_key=code


func has_key(code:String, is_enter:bool=true) -> bool:
	return _get_dico(is_enter).has(code)

func set_key_value(code:String, text:String, is_enter:bool=true) -> void:
	if _ignore_case_for_key:
		code = code.to_lower()
	_get_dico(is_enter)[code] = [text]

func remove_key(code:String, is_enter:bool=true) -> void:
	var dico = _get_dico(is_enter)
	if dico.has(code):
		dico.erase(code)

func append_key_value(code:String, text:String, is_enter:bool=true) -> void:
	if _ignore_case_for_key:
		code = code.to_lower()
	var dico = _get_dico(is_enter)
	if dico.has(code):
		dico[code].append(text)
	else:
		dico[code] = [text]

func append_key_value_to_enter_trigger(key:String, text:String) -> void:
	append_key_value(key, text, true)
func append_key_value_to_exit_trigger(key:String, text:String) -> void:
	append_key_value(key, text, false)


const line_return_splitter:String = "\n"
const diamond_splitter:String = "♦️"

func set_key_value_from_text_enter_diamond_splitter(text:String) -> void:
	_text_to_lists_dico_enter.clear()
	_append_key_value_from_text(text, true, diamond_splitter, line_return_splitter)

func set_key_value_from_text_exit_diamond_splitter(text:String) -> void:
	_text_to_lists_dico_exit.clear()
	_append_key_value_from_text(text, false, diamond_splitter, line_return_splitter)


func set_key_value_from_text_enter(text:String,key_value_splitter:String=":", line_splitter:String="\n") -> void:
	_text_to_lists_dico_enter.clear()
	_append_key_value_from_text(text, true, key_value_splitter, line_splitter)

func set_key_value_from_text_exit(text:String,key_value_splitter:String=":", line_splitter:String="\n") -> void:
	_text_to_lists_dico_exit.clear()
	_append_key_value_from_text(text, false, key_value_splitter, line_splitter)


func append_key_value_from_text_enter(text:String, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	_append_key_value_from_text(text, true, key_value_splitter, line_splitter)
	
func append_key_value_from_text_exit(text:String, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	_append_key_value_from_text(text, false, key_value_splitter, line_splitter)
	
func _append_key_value_from_text(text:String, is_enter:bool=true, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	if _ignore_case_for_key:
		text = text.to_lower()

	var lines = text.split(line_splitter, false)
	for line in lines:
		var key_value = line.split(key_value_splitter, false)
		if key_value.size() == 2:
			var code = key_value[0].strip_edges()
			var value = key_value[1].strip_edges()
			append_key_value(code, value, is_enter)
		if key_value.size() == 1:
			var code = key_value[0].strip_edges()
			append_key_value(code, "", is_enter)
