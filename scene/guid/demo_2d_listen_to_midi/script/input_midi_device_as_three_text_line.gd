class_name InputMidiDeviceAsThreeTextLine
extends Node

signal on_midi_as_string_updated(text: String)

@export_multiline var _midi_info_as_text:String = """
MIDI Device Info:\n
0000000...009999000\n
0000000...009999000\n
"""

func push_in_device_info(device_name: String, note_array_ref:Array[int], control_array_ref:Array[int]) -> void:
	_midi_info_as_text = "MIDI Device Info: " + device_name + "\n"
	_midi_info_as_text += "Notes: " + _0_127_to_0_9_array(note_array_ref) + "\n"
	_midi_info_as_text += "Controls: " + _0_127_to_0_9_array(control_array_ref) + "\n"
	on_midi_as_string_updated.emit(_midi_info_as_text)

func _0_127_to_0_9_array(values: Array[int]) -> String:
	var result: String = ""
	for value in values:
		result += str(_0_127_to_0_9(value))
	return result

func _0_127_to_0_9(value:int) -> int:
	return int(value / 12.8)
