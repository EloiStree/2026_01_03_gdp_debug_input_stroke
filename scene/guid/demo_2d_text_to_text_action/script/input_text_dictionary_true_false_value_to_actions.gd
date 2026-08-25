class_name InputTextDictionaryTrueFalseValueToActions
extends Node


signal on_action_found_with_key_as_array(key:String, action_names:Array[String])
signal on_action_found_as_array(action_names:Array[String])
signal on_action_found_with_key(key:String, action_name:String)
signal on_action_found(action_name:String)
signal on_action_not_found_with_key(key:String)

@export var _dictionary_text_true_to_action:Dictionary[String,Array] = {}
@export var _dictionary_text_false_to_action:Dictionary[String,Array] = {}

@export var _use_debug_log:bool =true
@export var _last_key_received:String
@export var _last_boolean_value_received:bool
@export var _last_found_value:Array


func emit_if_equals_to_text_in_true_dictionary(key:String) -> void:
	emit_if_equals_to_text_in_true_or_false_dictionary(key, true)

func emit_if_equals_to_text_in_false_dictionary(key:String) -> void:
	emit_if_equals_to_text_in_true_or_false_dictionary(key, false)

func emit_if_equals_to_text_in_true_or_false_dictionary(key:String, boolean_value:bool) -> void:
	_last_key_received = key
	_last_boolean_value_received = boolean_value
	if boolean_value:
		if _dictionary_text_true_to_action.has(key):
			var action_names:Array = _dictionary_text_true_to_action[key]
			on_action_found_with_key.emit(key, action_names)
			on_action_found.emit(action_names)
			_last_found_value = action_names
			on_action_found_with_key_as_array.emit(key, action_names)
			on_action_found_as_array.emit(action_names)
			for action_name in action_names:
				on_action_found_with_key.emit(key, action_name)
				on_action_found.emit(action_name)
			if _use_debug_log:
				print("Equals to key: ", key, " action_names: ", action_names)
		else:
			on_action_not_found_with_key.emit(key)
			_last_found_value = []
	else:
		if _dictionary_text_false_to_action.has(key):
			var action_names:Array = _dictionary_text_false_to_action[key]
			on_action_found_with_key.emit(key, action_names)
			on_action_found.emit(action_names)
			_last_found_value = action_names
			on_action_found_with_key_as_array.emit(key, action_names)
			on_action_found_as_array.emit(action_names)
			for action_name in action_names:
				on_action_found_with_key.emit(key, action_name)
				on_action_found.emit(action_name)
			if _use_debug_log:
				print("Equals to key: ", key, " action_names: ", action_names)
		else:
			on_action_not_found_with_key.emit(key)
			_last_found_value = []
	

func get_action_from_key(key:String) -> Array[String]:
	if _dictionary_text_true_to_action.has(key):
		return _dictionary_text_true_to_action[key]
	elif _dictionary_text_false_to_action.has(key):
		return _dictionary_text_false_to_action[key]
	else:
		return []

func get_dictionary_for_true_value() -> Dictionary[String,Array]:
	return  _dictionary_text_true_to_action
	
func get_dictionary_for_false_value() -> Dictionary[String,Array]:
	return  _dictionary_text_false_to_action

# func set_key_value_in_dictionary(key:String, action_names:Array[String]):
# 	_dictionary_text_to_action[key] = action_names

# func remove_key_from_dictionary(key:String):
# 	if _dictionary_text_to_action.has(key):
# 		_dictionary_text_to_action.erase(key)

func clear_dictionary():
	_dictionary_text_false_to_action.clear()
	_dictionary_text_true_to_action.clear()

func append_one_key_value_in_dictionary_for_true(key:String, action:String):
	append_several_key_value_in_dictionary_for_true(key,[action])

func append_several_key_value_in_dictionary_for_true(key:String, action_names:Array[String]):
	if _dictionary_text_true_to_action.has(key):
		var existing_actions:Array[String] = _dictionary_text_true_to_action[key]
		existing_actions.append_array(action_names)
		_dictionary_text_true_to_action[key] = existing_actions
	else:
		_dictionary_text_true_to_action[key] = action_names


func append_one_key_value_in_dictionary_for_false(key:String, action:String):
	append_several_key_value_in_dictionary_for_false(key,[action])

func append_several_key_value_in_dictionary_for_false(key:String, action_names:Array[String]):
	if _dictionary_text_false_to_action.has(key):
		var existing_actions:Array[String] = _dictionary_text_false_to_action[key]
		existing_actions.append_array(action_names)
		_dictionary_text_false_to_action[key] = existing_actions
	else:
		_dictionary_text_false_to_action[key] = action_names
