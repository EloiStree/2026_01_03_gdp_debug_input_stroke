class_name InputNfcTextToText
extends Node

signal on_text_value_found(text:String)
signal on_text_key_value_found(code:String, text:String)
signal on_text_key_not_found(code:String)

@export var text_to_scene_name_dico:Dictionary[String,String]

func try_to_emit_store_text_from_key(code:String) -> void:
	if text_to_scene_name_dico.has(code):
		var text = text_to_scene_name_dico[code]
		on_text_key_value_found.emit(code, text)
		on_text_value_found.emit(text)
	else:
		on_text_key_not_found.emit(code)


func has_key(code:String) -> bool:
	return text_to_scene_name_dico.has(code)

func set_key_value(code:String, text:String) -> void:
	text_to_scene_name_dico[code] = text

func remove_key(code:String) -> void:
	if text_to_scene_name_dico.has(code):
		text_to_scene_name_dico.erase(code)

func append_key_value(code:String, text:String) -> void:
	if text_to_scene_name_dico.has(code):
		text_to_scene_name_dico[code] += text
	else:
		text_to_scene_name_dico[code] = text


func append_key_value_from_path_file(path:String, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		append_key_value_from_text_file(text, key_value_splitter, line_splitter)
		file.close()

func append_key_value_from_text_file(text:String, key_value_splitter:String=":", line_splitter:String="\n") -> void:
	var lines = text.split(line_splitter, false)
	for line in lines:
		var key_value = line.split(key_value_splitter, false)
		if key_value.size() == 2:
			var code = key_value[0].strip_edges()
			var value = key_value[1].strip_edges()
			append_key_value(code, value)
		if key_value.size() == 1:
			var code = key_value[0].strip_edges()
			append_key_value(code, "")
