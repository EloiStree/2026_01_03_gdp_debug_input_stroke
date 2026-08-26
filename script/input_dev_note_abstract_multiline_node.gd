## If your class inherits of this. It means that it should be simple note.
## But the class_name is a Tag of what represent the note/node.
class_name InputDevNoteAbstractMultilineNode
extends Node
	
@export_multiline var _note: String = ""
func get_text_note() -> String:
	return _note
	
func set_text_note(text: String) -> void:
	_note = text
