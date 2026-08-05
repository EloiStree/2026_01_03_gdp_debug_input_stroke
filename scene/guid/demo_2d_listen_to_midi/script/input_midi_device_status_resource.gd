class_name InputMidiDeviceStatusResource
extends Resource

@export var _midi_device_name: String = "Unknown MIDI Device"
## MIDI notes range from 0 to 127 (128 total).
@export var _note_velocity: Array[int] = []
## MIDI control change (CC) numbers also range from 0 to 127 (128 total).
@export var _control_value: Array[int] = []

func reset_all_value_to_zero() -> void:
	if _note_velocity.size() < 128:
		_note_velocity.resize(128)
	if _control_value.size() < 128:
		_control_value.resize(128)
	for i in range(128):
		_note_velocity[i] = 0
		_control_value[i] = 0

func set_midi_device_name(device_name: String) -> void:
	if _note_velocity.size() < 128:
		_note_velocity.resize(128)
	if _control_value.size() < 128:
		_control_value.resize(128)
	var new_device_name:bool = _midi_device_name != device_name
	if new_device_name:
		reset_all_value_to_zero()
	_midi_device_name = device_name

func is_the_device(device_name: String) -> bool:
	return _midi_device_name == device_name


func push_in_midi_note( note: int, velocity: int) -> void:
	if _note_velocity.size() < 128:
		_note_velocity.resize(128)
	if note >= 0 and note < 128:
		_note_velocity[note] = velocity

func push_in_midi_control( controller_number: int, controller_value: int) -> void:
	if _control_value.size() < 128:
		_control_value.resize(128)
	if controller_number >= 0 and controller_number < 128:
		_control_value[controller_number] = controller_value


func get_note_velocity(note: int) -> int:
	if _note_velocity.size() < 128:
		_note_velocity.resize(128)
	if note >= 0 and note < 128:
		return _note_velocity[note]
	return 0


func get_control_value(controller_number: int) -> int:
	if _control_value.size() < 128:
		_control_value.resize(128)
	if controller_number >= 0 and controller_number < 128:
		return _control_value[controller_number]
	return 0


func get_note_array_reference() -> Array[int]:
	if _note_velocity.size() < 128:
		_note_velocity.resize(128)
	return _note_velocity

func get_control_array_reference() -> Array[int]:
	if _control_value.size() < 128:
		_control_value.resize(128)
	return _control_value   
