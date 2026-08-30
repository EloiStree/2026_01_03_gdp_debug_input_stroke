class_name InputTextDictionaryToActions
extends Node

signal on_action_found_with_key_as_array(key:String, action_names:Array[String])
signal on_action_found_as_array(action_names:Array[String])
signal on_action_found_with_key(key:String, action_name:String)
signal on_action_found(action_name:String)
signal on_action_not_found_with_key(key:String)

@export var _dictionary_text_to_action:Dictionary[String,Array] = {}
@export var _use_debug_log:bool =false
@export var _last_received:String
@export var _last_found_value:Array

func emit_if_integer_equals_to_one_key(value:int):
	emit_if_text_equals_to_one_key(str(value))
	
func emit_if_text_equals_to_one_key(text:String):
	_last_received = text
	if _dictionary_text_to_action.has(text):
		var action_names:Array = _dictionary_text_to_action[text]
		on_action_found_with_key.emit(text, action_names)
		on_action_found.emit(action_names)
		_last_found_value = action_names
		on_action_found_with_key_as_array.emit(text, action_names)
		on_action_found_as_array.emit(action_names)
		for action_name in action_names:
			on_action_found_with_key.emit(text, action_name)
			on_action_found.emit(action_name)
		if _use_debug_log:
			print("Equals to key: ", text, " action_names: ", action_names)
	else:
		on_action_not_found_with_key.emit(text)
		_last_found_value = []
	

func emit_if_text_finishing_by_one_key(text:String):
	_last_received = text
	for key in _dictionary_text_to_action.keys():
		if text.ends_with(key):
			var action_names:Array = _dictionary_text_to_action[key]
			on_action_found_with_key_as_array.emit(key, action_names)
			on_action_found_as_array.emit(action_names)
			for action_name in action_names:
				on_action_found_with_key.emit(key, action_name)
				on_action_found.emit(action_name)
			_last_found_value = action_names
			if _use_debug_log:
				print("Finishing by key: ", key, " action_names: ", action_names)
			return
	on_action_not_found_with_key.emit(text)
	_last_found_value = []

func get_action_from_key(key:String) -> Array[String]:
	if _dictionary_text_to_action.has(key):
		return _dictionary_text_to_action[key]
	else:
		return []

func get_dictionary() -> Dictionary[String,Array]:
	return _dictionary_text_to_action

func set_key_value_in_dictionary(key:String, action_names:Array[String]):
	_dictionary_text_to_action[key] = action_names


func remove_key_from_dictionary(key:String):
	if _dictionary_text_to_action.has(key):
		_dictionary_text_to_action.erase(key)

func clear_dictionary():
	_dictionary_text_to_action.clear()


func append_array_of_key_value_in_dictionary(key:String, action_names:Array[String]	):
	for action_name in action_names:
		append_a_key_value_in_dictionary(key, action_name)

func append_a_key_value_in_dictionary(key:String, action:String):
	if _dictionary_text_to_action.has(key):
		var existing_actions:Array = _dictionary_text_to_action[key]
		existing_actions.append(action)
		_dictionary_text_to_action[key] = existing_actions
	else:
		_dictionary_text_to_action[key] = [action]
