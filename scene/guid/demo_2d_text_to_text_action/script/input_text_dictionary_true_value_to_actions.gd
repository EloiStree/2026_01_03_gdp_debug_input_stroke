class_name InputTextDictionaryTrueValueToActions
extends Node

signal on_action_found_with_key_as_array(key:String, action_names:Array[String])
signal on_action_found_as_array(action_names:Array[String])
signal on_action_found_with_key(key:String, action_name:String)
signal on_action_found(action_name:String)
signal on_action_not_found_with_key(key:String)

@export var _dictionary_text_true_to_action:Dictionary[String,Array] = {}

@export var _use_debug_log:bool =true
@export var _last_key_received:String
@export var _last_boolean_value_received:bool
@export var _last_found_value:Array


func emit_if_text_equals_to_key_and_value_is_true(key:String, boolean_value:bool) -> void:
	_last_key_received = key
	_last_boolean_value_received = boolean_value
	if boolean_value==true:
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

func clear_dictionary():
	_dictionary_text_true_to_action.clear()

func append_a_key_value_in_dictionary(key:String, action:String):
	if _dictionary_text_true_to_action.has(key):
		var existing_actions:Array[String] = _dictionary_text_true_to_action[key]
		existing_actions.append(action)
		_dictionary_text_true_to_action[key] = existing_actions
	else:
		_dictionary_text_true_to_action[key] = [action]