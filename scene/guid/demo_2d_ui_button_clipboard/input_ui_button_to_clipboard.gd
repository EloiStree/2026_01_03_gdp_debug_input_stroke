class_name InputUiButtonToClipboard
extends Button

@export var _use_text_if_empty: bool = true
@export_multiline() var _text_for_clipboard:String=""

func _ready() -> void:
	if _use_text_if_empty and _text_for_clipboard == "":
		_text_for_clipboard = self.text
	self.button_down.connect(push_text_in_clipboard)
	
func push_text_in_clipboard():
	DisplayServer.clipboard_set(_text_for_clipboard)
	
