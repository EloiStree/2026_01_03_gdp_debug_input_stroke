class_name InputListenToKeyboardUnicodeAsString
extends Node

signal on_any_unicode_char_found(unicode_char_as_string:String)

@export var use_print_debug: bool = false
@export var last_input_found: String = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		#if event.is_echo():
			#return
		var key_event := event as InputEventKey
		if key_event.unicode == 0 or key_event.unicode == 0xFFFD:
			return

		var unicode_char := char(key_event.unicode)
		last_input_found = unicode_char

		if use_print_debug:
			print("Key event unicode char: ", unicode_char, " unicode int: ", key_event.unicode )
		on_any_unicode_char_found.emit(unicode_char)
