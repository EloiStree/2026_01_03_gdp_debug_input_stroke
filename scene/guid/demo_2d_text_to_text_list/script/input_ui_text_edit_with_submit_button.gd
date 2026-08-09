class_name InputUITextEditWithSubmitButton
extends Node


signal on_text_edit_submit(text:String)
signal on_text_edit_text_changed(text:String)
signal on_submit_button_pressed(text:String)
signal on_text_edit_any_action(text:String)

@export var text_edit:TextEdit
@export var submit_button:Buttongm


func _ready():
	if text_edit:
		text_edit.text_changed.connect(Callable(self, "_on_text_edit_text_changed"))
		text_edit.text_submitted.connect(Callable(self, "_on_text_edit_submit"))
	if submit_button:
		submit_button.pressed.connect(Callable(self, "_on_submit_button_pressed"))
	
func _on_text_edit_text_changed(new_text:String):
	on_text_edit_text_changed.emit(new_text)
	on_text_edit_any_action.emit(new_text)

func _on_text_edit_submit(submitted_text:String):
	on_text_edit_submit.emit(submitted_text)
	on_text_edit_any_action.emit(submitted_text)

func _on_submit_button_pressed():
	if text_edit:
		var text = text_edit.text
		on_submit_button_pressed.emit(text)
		on_text_edit_any_action.emit(text)
