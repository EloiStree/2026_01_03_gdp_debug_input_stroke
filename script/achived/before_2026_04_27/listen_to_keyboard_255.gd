class_name ListenToKeyboard255
extends Node

signal on_first_time_key_on(key_code: int)
signal on_key_on_off(key_code: int, value_is_down: bool)
signal on_key_on_off_with_label(key_code: int, label_name: String, value_is_down: bool)



@export var keys_id_255_to_label_name: Array[String] = []


func set_label_of_key_id(key_id_0_255: int, label_name: String) -> void:
	if key_id_0_255 < 0:
		return
	if key_id_0_255>255:
		return
	if keys_id_255_to_label_name.size() != 256:
		keys_id_255_to_label_name.resize(256)
	keys_id_255_to_label_name[key_id_0_255] = label_name


func get_label_of_key_id(key_id_0_255: int) -> String:
	if key_id_0_255 < 0:
		return ""
	if key_id_0_255>255:
		return ""
	if keys_id_255_to_label_name.size() != 256:
		keys_id_255_to_label_name.resize(256)
	return keys_id_255_to_label_name[key_id_0_255]


var key_states := {}

func _process(_delta: float) -> void:
	for key_code in range(0,255):
		var is_down := Input.is_key_pressed(key_code)
		if key_states.has(key_code):
			if key_states[key_code] != is_down:
				key_states[key_code] = is_down
				on_key_on_off.emit(key_code, is_down)
				on_key_on_off_with_label.emit(key_code, get_label_of_key_id(key_code), is_down)
		else:
			key_states[key_code] = is_down
			on_first_time_key_on.emit(key_code)
			on_key_on_off.emit(key_code, is_down)
			on_key_on_off_with_label.emit(key_code, get_label_of_key_id(key_code), is_down)
