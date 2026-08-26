class_name InputByteArrayToActions
extends Node

signal on_action_found_with_key_as_array(key:String, action_names:Array[String])
signal on_action_found_as_array(action_names:Array[String])
signal on_action_found_with_key(key:String, action_name:String)
signal on_action_found(action_name:String)
signal on_action_not_found_with_key(key:String)


@export var _byte_array_to_list_of_action:Array[Array] = []

@export var _use_debug_log:bool =true
@export var _last_received:int
@export var _last_found_value:Array

func emit_if_string_integer_equals_to_integer_key(index:String):
	if index.is_valid_int():
		var value:int = index.to_int()
		emit_if_integer_equals_to_integer_key(value)

func emit_if_integer_equals_to_integer_key(index:int):
	_last_received = index
	if index<0 or index>255:
		return

	if index < _byte_array_to_list_of_action.size():
		var action_names:Array[String] = _byte_array_to_list_of_action[index]
		if action_names!=null:
			_last_found_value = action_names
			on_action_found_with_key_as_array.emit(str(index), action_names)
			on_action_found_as_array.emit(action_names)
			for action_name in action_names:
				on_action_found_with_key.emit(str(index), action_name)
				on_action_found.emit(action_name)
		else:
			on_action_not_found_with_key.emit( str(index))
	else:
		on_action_not_found_with_key.emit(str(index))



func append_a_integer_key_value_in_dictionary(key_index_0_255:int, action:String):
	## if index
	if key_index_0_255<0 or key_index_0_255>255:
		return
	_byte_array_to_list_of_action.resize(256)
	var key:int = key_index_0_255
	if _byte_array_to_list_of_action[key]==null:
		_byte_array_to_list_of_action[key] = []
	_byte_array_to_list_of_action[key].append(action)

	