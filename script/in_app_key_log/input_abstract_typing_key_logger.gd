## Key logger only do the keyboard. But in game we have XR, Gamepad and specifique device, UI....
## This class do like a key logger but it is to the developer to give the char.
class_name InputAbstractTypingKeyLogger
extends Node


signal on_string_builder_changed(builder_string:String)
signal on_list_changed( list_of_characters:Array[String])
signal on_key_string_appended(key_string:String)


@export var _memory_list: Array[String] = []
@export var _max_memory_length:int=100
@export var _typed_string_builder:String=""


func inject_key_as_string(key_as_string:String) -> void:
	_memory_list.append(key_as_string)
	if _memory_list.size() > _max_memory_length:
		_memory_list.remove_at(0)
	
	_typed_string_builder ="".join(_memory_list)
	on_key_string_appended.emit(key_as_string)
	on_string_builder_changed.emit(_typed_string_builder)
	on_list_changed.emit(_memory_list)


func clear_memory() -> void:
	_memory_list.clear()
	_typed_string_builder=""
	on_string_builder_changed.emit(_typed_string_builder)
	on_list_changed.emit(_memory_list)


func is_finishing_by(key_as_string:String) -> bool:
	return _typed_string_builder.ends_with(key_as_string)
