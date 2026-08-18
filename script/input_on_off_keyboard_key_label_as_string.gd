
class_name InputListenToKeyboardAsStringNoModifiers
extends Node

signal on_event_key_stroke_as_given_by_godot(text:String, is_on:bool)
signal on_event_key_stroke_label_without_modifiers(text:String, is_on:bool)
#signal on_event_key_stroke_with_array_of_modifiers(modifiers:Array[String], text:String,is_on:bool )

@export var use_print_debug: bool = true
@export var last_input_word_found: String 

func _input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		var typed := event.as_text()
		var is_on: bool = event.is_pressed()
		
		var str: PackedStringArray = typed.to_lower().replace("+", " ").split(" ")
		var word: String = "" if str.size() == 0 else str[str.size() - 1]
		#var modifiers: Array[String] = str.slice(0, str.size() - 1)
		
		last_input_word_found = word
		
		on_event_key_stroke_label_without_modifiers.emit(word, is_on)
		on_event_key_stroke_as_given_by_godot.emit(typed, is_on)
		#on_event_key_stroke_with_array_of_modifiers.emit(modifiers, word, is_on)
		
		if use_print_debug:
			print("Typed: ", typed, " On:", is_on)

	
	
