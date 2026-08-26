class_name InputUiLineEditWithSubmitButton
extends Node

signal on_line_edit_text_changed(text:String)
signal on_line_edit_text_submit(text:String)
signal on_submit_button_pressed(text:String)
signal on_submit_button_released(text:String)

@export var line_edit:LineEdit
@export var submit_button:Button

@export var _prefix:String = ""
@export var _suffix:String = ""

func _ready():
	if line_edit:
		line_edit.text_changed.connect(_on_line_edit_text_changed)
		line_edit.text_submitted.connect(_on_line_edit_submit)
	if submit_button:
		submit_button.button_down.connect( _on_submit_button_pressed)
	if submit_button:
		submit_button.button_up.connect( _on_submit_button_released)
	
func _on_line_edit_text_changed(new_text:String):
	on_line_edit_text_changed.emit(get_text_with_prefix_and_suffix())

func _on_line_edit_submit(submitted_text:String):
	on_line_edit_text_submit.emit(get_text_with_prefix_and_suffix())
	
func _on_submit_button_pressed():
	if line_edit:
		var text = line_edit.text
		on_submit_button_pressed.emit(get_text_with_prefix_and_suffix())

func _on_submit_button_released():
	if line_edit:
		var text = line_edit.text
		on_submit_button_released.emit(get_text_with_prefix_and_suffix())

func get_text_with_prefix_and_suffix() -> String:
	var text:String = ""
	if line_edit:
		text = line_edit.text
	if _prefix != null and not _prefix.is_empty():
		text = _prefix + text
	if _suffix != null and not _suffix.is_empty():
		text = text + _suffix
	return text
