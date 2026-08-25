## Listen to char type in the application (not outside of the application) and build a string code from it.
class_name InputKeyboardLocalUnicodeTypingLogger
extends Node


signal on_string_builder_changed(builder_string:String)
signal on_list_changed( list_of_characters:Array[String])

signal on_any_unicode_integer_found(unicode_id:int)
signal on_any_unicode_character_found(unicode_char:String)


@export var _typed_string_builder:String=""
@export var _max_memory_length:int=100

@export var _use_print_debug: bool = true
@export var _last_input_found: int =0

@export_group("Debug Memory List")
@export var _memory_list: Array[String] = []

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_echo():
			return
		var key_event := event as InputEventKey
		var unicode:int= key_event.unicode
		if unicode==0:
			return

		var unicode_char := char(key_event.unicode)
		if _use_print_debug:
			print(key_event.unicode)

		_memory_list.append(unicode_char)
		if _memory_list.size() > _max_memory_length:
			_memory_list.remove_at(0)
		
		_typed_string_builder ="".join(_memory_list)
		_last_input_found = unicode
		on_any_unicode_integer_found.emit(unicode)
		on_any_unicode_character_found.emit(unicode_char)
		on_string_builder_changed.emit(_typed_string_builder)
		on_list_changed.emit(_memory_list)



func is_finishing_by(key_as_string:String) -> bool:
	return _typed_string_builder.ends_with(key_as_string)
