class_name InputTextFileFromGodotProject
extends Node


signal on_text_file_loaded(text:String)


@export_file("*.txt") var _file_path: String
@export var _load_at_ready:bool = true

@export_group("UI")
@export var _text_edit_to_affect:Array[TextEdit] = []
@export var _code_edit_to_affect:Array[CodeEdit] = []


func _ready() -> void:
	if _load_at_ready:
		load_text_file_from_resource()






func load_text_file_from_resource() -> void:
	if _file_path == "":
		push_warning("No file path assigned.")
		return

	var file_path = _file_path

	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		push_warning("Failed to open the file: " + file_path)
		return

	var text_content = file.get_as_text()
	file.close()

	on_text_file_loaded.emit( text_content)

	for text_edit in _text_edit_to_affect:
		if text_edit != null:
			text_edit.text = text_content

	for code_edit in _code_edit_to_affect:
		if code_edit != null:
			code_edit.text = text_content
