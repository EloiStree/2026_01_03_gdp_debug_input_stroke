class_name InputListenToMidiAsAbInput
extends Node

signal on_midi_note_analog_key_value(key_name: String, value: float)
signal on_midi_note_boolean_key_value(key_name: String, value: bool)
signal on_midi_control_analog_key_value(key_name: String, value: float)


@export var _listen_to_midi: InputListenToMidi = null
@export var _analog_note_format:String ="{device_name}|AN|{spawn_index}|{channel}|{note}"
@export var _boolean_note_format:String ="{device_name}|BN|{spawn_index}|{channel}|{note}"
@export var _analog_control_format:String ="{device_name}|AC|{spawn_index}|{control}"



func _ready() -> void:
    if _listen_to_midi == null:
        push_error("InputListenToMidiAsAbInput: _listen_to_midi is not assigned.")
        return

    _listen_to_midi.on_any_midi_in_note_changed.connect(_on_manage_midi_event)
    _listen_to_midi.on_any_midi_in_control_changed.connect(_on_manage_midi_controller_event)


func _on_manage_midi_event(
	midi_device_name: String,
	spawn_index: int,
	channel: int,
	note: int,
	velocity: int
) -> void:

    var value: float = velocity
    var key :String = _analog_note_format.format({
        "device_name": midi_device_name,
        "spawn_index": spawn_index,
        "channel": channel,
        "note": note
    })
    on_midi_note_analog_key_value.emit(key, value)
        
    var is_note_off: bool = velocity == 0
    var boolean_key :String = _boolean_note_format.format({
        "device_name": midi_device_name,
        "spawn_index": spawn_index,
        "channel": channel,
        "note": note
    })
    on_midi_note_boolean_key_value.emit(boolean_key, not is_note_off)



func _on_manage_midi_controller_event(
	midi_device_name: String,
	spawn_index: int,
	controller_number: int,
	controller_value: int
) -> void:

    var value: float = controller_value
    var key :String = _analog_control_format.format({
        "device_name": midi_device_name,
        "spawn_index": spawn_index,
        "control": controller_number
    })
    on_midi_control_analog_key_value.emit(key, value)