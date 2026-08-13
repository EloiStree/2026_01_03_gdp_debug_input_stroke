class_name InputTextDictionaryActionIfEqualsTo
extends Node


signal on_action_found_with_key(key:String, action_name:String)
signal on_action_found(action_name:String)
signal on_action_not_found_with_key(key:String)

@export var _dictionary_text_to_action:Dictionary = {
	"123":"BAR_DOWN",
	"456":"BAR_MIDDLE",
	"789":"BAR_UP",
	"147":"VERTICAL_LEFT",
	"369":"VERTICAL_RIGHT",
	"258":"VERTICAL_MIDDLE",
	"159":"DIAGONAL_LEFT",
	"357":"DIAGONAL_RIGHT",
}

@export var _last_received:String
@export var _last_found_value:String

func emit_if_equals_text_equals_to_one_key(text:String):
	_last_received = text
	if _dictionary_text_to_action.has(text):
		var action_name:String = _dictionary_text_to_action[text]
		on_action_found_with_key.emit(text, action_name)
		on_action_found.emit(action_name)
		_last_found_value = action_name
	else:
		on_action_not_found_with_key.emit(text)
		_last_found_value = ""

func get_action_from_key(key:String) -> String:
	if _dictionary_text_to_action.has(key):
		return _dictionary_text_to_action[key]
	else:
		return ""

func get_dictionary() -> Dictionary:
	return _dictionary_text_to_action

func set_key_value_in_dictionary(key:String, action_name:String):
	_dictionary_text_to_action[key] = action_name

func remove_key_from_dictionary(key:String):
	if _dictionary_text_to_action.has(key):
		_dictionary_text_to_action.erase(key)

func clear_dictionary():
	_dictionary_text_to_action.clear()
