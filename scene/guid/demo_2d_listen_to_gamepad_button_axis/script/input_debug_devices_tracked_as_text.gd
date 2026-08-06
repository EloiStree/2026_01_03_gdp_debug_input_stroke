class_name InputDebugAllDevicesTrackedAsText
extends Node

signal on_new_device_tracked(device: InputListenToDevicesAxisAndButtons.DeviceTracked)
signal on_refresh_devices_status_as_text(devices_as_text: String)
signal on_devices_list_name_changed(list_of_devices_name: Array[String])

@export_multiline var _devices_as_text: String = ""
@export var _list_of_devices_name: Array[String] = []
var _devices_list: Array[InputListenToDevicesAxisAndButtons.DeviceTracked] = []



func push_in_new_device_state(device: InputListenToDevicesAxisAndButtons.DeviceTracked) -> void:
	if device == null:
		return
	if not _devices_list.has(device):
		_devices_list.append(device)
		_devices_as_text += "\n" + device.get_three_line_debug()
		on_new_device_tracked.emit(device)
		_list_of_devices_name.clear()
		for d in _devices_list:
			if d != null:
				_list_of_devices_name.append(d._device_name)
		on_refresh_devices_status_as_text.emit(_devices_as_text)
		on_devices_list_name_changed.emit(_list_of_devices_name)

func _process(_delta: float) -> void:
	_devices_as_text = ""
	_list_of_devices_name.clear()
	for device in _devices_list:
		if device != null:
			_devices_as_text += "\n" + device.get_three_line_debug()
			_list_of_devices_name.append(device._device_name)
	on_refresh_devices_status_as_text.emit(_devices_as_text)
	on_devices_list_name_changed.emit(_list_of_devices_name)
	
