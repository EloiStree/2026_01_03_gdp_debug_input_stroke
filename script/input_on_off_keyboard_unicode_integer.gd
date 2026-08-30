class_name InputListenToKeyboardUnicodeAsInteger
extends Node

signal on_any_unicode_integer_found(unicode_id:int)
signal on_any_unicode_integer_as_string_found(unicode_id_as_string:String)

@export var _use_print_debug: bool = false
@export var _last_input_found: int = 0

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
			print(key_event.unicode,"-",unicode_char)
		_last_input_found = unicode

		on_any_unicode_integer_found.emit(unicode)
		on_any_unicode_integer_as_string_found.emit(str(unicode))
	
