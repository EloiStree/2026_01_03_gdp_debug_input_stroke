class_name ListenToChar extends Node

signal on_char_detected(char_found:String)

@export var use_print_for_debug:=false
func _input(event):
	if event is InputEventKey and event.pressed and event.unicode > 0:
		var char := char(event.unicode)
		if use_print_for_debug:
			print("Typed character:", char)
		on_char_detected.emit(char)
