class_name InputMidiDevicesKeyControlDictionary
extends Node

signal on_midi_device_changed(device:InputMidiDeviceStatusResource)
signal on_midi_device_as_array_ref_changed(device_name:String, note_array_ref:Array[int], control_array_ref:Array[int])
signal on_new_device_added(device_name: String)
signal on_device_removed(device_name: String)

signal on_any_midi_in_note_changed_as_string(text: String)
signal on_any_midi_in_control_changed_as_string(text: String)

signal on_any_midi_in_note_updated(
	midi_device_name: String,
	note: int,
	new_velocity: int
)
signal on_any_midi_in_control_updated(
	midi_device_name: String,
	controller_number: int,
	new_value: int
)


signal on_any_midi_in_note_changed(
	midi_device_name: String,
	note: int,
	previous_velocity: int,
	new_velocity: int
)
signal on_any_midi_in_control_changed(
	midi_device_name: String,
	controller_number: int,
	previous_value: int,
	new_value: int
)


@export var _devices_dictionary: Dictionary[String,InputMidiDeviceStatusResource] = {
}


func remove_midi_device(device_name: String) -> void:
	if _devices_dictionary.has(device_name):
		_devices_dictionary.erase(device_name)
		on_device_removed.emit(device_name)

func push_in_midi_note(device_name: String,spawn_index:int,channel:int, note: int, velocity: int) -> void:
	var device_status: InputMidiDeviceStatusResource=null
	if not _devices_dictionary.has(device_name):
		_devices_dictionary[device_name] = InputMidiDeviceStatusResource.new()
		_devices_dictionary[device_name].set_midi_device_name(device_name)
		device_status = _devices_dictionary[device_name]
		on_new_device_added.emit(device_name)
	else :
		device_status = _devices_dictionary[device_name]

	var previous_velocity:int = device_status.get_note_velocity(note)
	if previous_velocity != velocity:
		device_status.push_in_midi_note(note, velocity)
		on_any_midi_in_note_changed.emit(device_name, note, previous_velocity, velocity)
		on_any_midi_in_note_updated.emit(device_name, note, velocity)
		on_midi_device_changed.emit(device_status)
		on_midi_device_as_array_ref_changed.emit(device_name, device_status.get_note_array_reference(), device_status.get_control_array_reference())	



func push_in_midi_control(device_name: String,spawn_index:int, controller_number: int, controller_value: int) -> void:
	var device_status: InputMidiDeviceStatusResource=null
	if not _devices_dictionary.has(device_name):
		_devices_dictionary[device_name] = InputMidiDeviceStatusResource.new()
		_devices_dictionary[device_name].set_midi_device_name(device_name)
		device_status = _devices_dictionary[device_name]
		on_new_device_added.emit(device_name)
	else :
		device_status = _devices_dictionary[device_name]
	
	var previous_value:int = device_status.get_control_value(controller_number)
	if previous_value != controller_value:
		device_status.push_in_midi_control(controller_number, controller_value)
		on_any_midi_in_control_changed.emit(device_name, controller_number, previous_value, controller_value)
		on_any_midi_in_control_updated.emit(device_name, controller_number, controller_value)
		on_midi_device_changed.emit(device_status)
		on_midi_device_as_array_ref_changed.emit(device_name, device_status.get_note_array_reference(), device_status.get_control_array_reference())
