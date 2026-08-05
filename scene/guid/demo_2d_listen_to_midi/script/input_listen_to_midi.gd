class_name InputListenToMidi
extends Node

signal on_unsourced_midi_note_changed(
	note: int,
	velocity: int
)
signal on_unsourced_midi_control_changed(
	controller_number: int,
	controller_value: int
)

signal on_any_midi_in_note_changed(
	midi_device_name: String,
	channel: int,
	note: int,
	velocity: int
)
signal on_any_midi_in_note_changed_as_string(text: String)


# Yes, Godot's InputEventMIDI has a "message" field which can be
# MIDI_MESSAGE_CONTROL_CHANGE (Control Change / CC) among other MIDI messages.
signal on_any_midi_in_control_changed(
	midi_device_name: String,
	channel: int,
	controller_number: int,
	controller_value: int
)

signal on_any_midi_in_control_changed_as_string(text: String)

@export var _use_print_log: bool = true

@export var _midi_note_format_string: String = "ND: {device_name}, C: {channel}, N: {note}, V: {velocity}"
@export var _midi_control_format_string: String = "CD: {device_name}, C: {channel}, N: {controller_number}, V: {controller_value}"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello World - Listening to MIDI input...")

	# Open MIDI input devices so _input() receives InputEventMIDI events.
	OS.open_midi_inputs()

	var connected_inputs: PackedStringArray = OS.get_connected_midi_inputs()
	if connected_inputs.is_empty():
		print("No MIDI devices found.")
	else:
		print("Connected MIDI devices: ", connected_inputs)
		print("Listening to all connected MIDI devices...")

func _input(event: InputEvent) -> void:
	if event is InputEventMIDI:
		var connected_inputs: PackedStringArray = OS.get_connected_midi_inputs()
		var device_name: String = ""
		if event.device >= 0 and event.device < connected_inputs.size():
			device_name = connected_inputs[event.device]

		if _use_print_log:
			print("MIDI event source device: ", event.device)
			print("MIDI event source device name: ", device_name)

		if event.message == MIDI_MESSAGE_CONTROL_CHANGE:
			_manage_midi_controller_event(device_name, event)
		else:
			_manage_midi_event(device_name, event)
			


func _exit_tree() -> void:
	OS.close_midi_inputs()


func _manage_midi_controller_event(device_name: String, midi_event: InputEventMIDI) -> void:
	if _use_print_log:
		print("Hello World from MIDI Control Change!")
		print("  Channel: ", midi_event.channel)
		print("  Controller Number: ", midi_event.controller_number)
		print("  Controller Value: ", midi_event.controller_value)

	on_any_midi_in_control_changed.emit(
		device_name,
		midi_event.channel,
		midi_event.controller_number,
		midi_event.controller_value
	)
	on_unsourced_midi_control_changed.emit(
		midi_event.controller_number,
		midi_event.controller_value
	)

	var control_text: String = _midi_control_format_string.format({
		"device_name": device_name,
		"channel": midi_event.channel,
		"controller_number": midi_event.controller_number,
		"controller_value": midi_event.controller_value,
	})
	on_any_midi_in_control_changed_as_string.emit(control_text)


func _manage_midi_event(device_name: String, midi_event: InputEventMIDI) -> void:

	if _use_print_log:
		print("Hello World from MIDI!")
		print("  Channel: ", midi_event.channel)
		print("  Message: ", midi_event.message)
		print("  Pitch: ", midi_event.pitch)
		print("  Velocity: ", midi_event.velocity)
		print("  Instrument: ", midi_event.instrument)
		print("  Pressure: ", midi_event.pressure)
		print("  Controller Number: ", midi_event.controller_number)
		print("  Controller Value: ", midi_event.controller_value)

	on_any_midi_in_note_changed.emit(
		device_name,
		midi_event.channel,
		midi_event.pitch,
		midi_event.velocity
	)
	on_unsourced_midi_note_changed.emit(
		midi_event.pitch,
		midi_event.velocity
	)

	var note_text: String = _midi_note_format_string.format({
		"device_name": device_name,
		"channel": midi_event.channel,
		"note": midi_event.pitch,
		"velocity": midi_event.velocity,
	})
	on_any_midi_in_note_changed_as_string.emit(note_text)
