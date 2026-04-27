class_name InputFilterByDevicesName 
extends Node



signal on_new_device_tracked(device_index: int, apparition_index: int, device_name: String)
signal on_axis_changed(device_index: int, apparition_index: int, axis_index: int, previous_axis_value: float, new_axis_value: float)
signal on_button_changed(device_index: int, apparition_index: int, button_index: int,  new_button_value: bool)

@export var devices_manager: ListenToDevicesAxisAndButtons

@export var devices_name_to_filter :Array[String] = ["NES Harward Name","NES"]
@export var ignore_case_in_device_name_filter : bool = true
@export var trim_device_name_before_filter : bool = true
@export var use_debug_print:bool=false

var apparition_devices_godot_index : Array[DeviceGodotIndexToApparitionIndex] = []

class DeviceGodotIndexToApparitionIndex:
	var device_godot_index: int
	var apparition_index: int


func _ready() -> void:
	
	devices_manager.on_new_device_tracked.connect(_on_new_device_tracked)
	devices_manager.on_button_changed.connect(_on_button_changed)
	devices_manager.on_axis_changed.connect(_on_axis_changed)

func is_device_name_matching_filter(device_name: String) -> bool:
	var name_to_check = device_name
	if trim_device_name_before_filter:
		name_to_check = name_to_check.strip_edges()
	if ignore_case_in_device_name_filter:
		name_to_check = name_to_check.to_lower()
	for filter_name in devices_name_to_filter:
		var filter_to_check = filter_name
		if trim_device_name_before_filter:
			filter_to_check = filter_to_check.strip_edges()
		if ignore_case_in_device_name_filter:
			filter_to_check = filter_to_check.to_lower()
		if name_to_check == filter_to_check:
			return true
	return false

func check_or_add_apparition_device(device_index: int):
	
	for device in apparition_devices_godot_index:
		if device.device_godot_index == device_index:
			return 
	var new_apparition_index = apparition_devices_godot_index.size()
	var new_device_mapping = DeviceGodotIndexToApparitionIndex.new()
	new_device_mapping.device_godot_index = device_index
	new_device_mapping.apparition_index = new_apparition_index
	apparition_devices_godot_index.append(new_device_mapping)
	return 
func find_device_allowed(device_index: int) -> int:
	for device in apparition_devices_godot_index:
		if device.device_godot_index == device_index:
			return device.apparition_index
	return -1

func get_device_name_from_index(device_index: int) -> String:
	return devices_manager.get_device_name_by_godot_index(device_index)

func _on_new_device_tracked(device_index: int,apparition:int, device_name: String):
	if not is_device_name_matching_filter(device_name):
		return
	check_or_add_apparition_device(device_index)
	on_new_device_tracked.emit(device_index, apparition, device_name)
	if use_debug_print:
		print("New Device Tracked - Index: ", device_index, " Apparition: ", apparition, " Name: ", device_name)

func _on_axis_changed(device_index: int,apparition:int, axis_index: int, previous_axis_value: float, new_axis_value: float):
	var device_name = get_device_name_from_index(device_index)
	if use_debug_print:
		print("Axis Changed - Device Index: ", device_index, " Apparition: ", apparition, " Axis Index: ", axis_index, " Previous Value: ", previous_axis_value, " New Value: ", new_axis_value)
	if not is_device_name_matching_filter(device_name):
		return
	check_or_add_apparition_device(device_index)
	var apparition_index = find_device_allowed(device_index)
	if apparition_index != -1:
		if use_debug_print:
			print("Axis Changed - Device Index: ", device_index, " Apparition: ", apparition_index, " Axis Index: ", axis_index, " Previous Value: ", previous_axis_value, " New Value: ", new_axis_value)
		on_axis_changed.emit(device_index, apparition_index, axis_index, previous_axis_value, new_axis_value)

func _on_button_changed(device_index: int,apparition:int, button_index: int, new_button_value: bool):
	var device_name = get_device_name_from_index(device_index)
	if not is_device_name_matching_filter(device_name):
		return
	check_or_add_apparition_device(device_index)
	var apparition_index = find_device_allowed(device_index)
	if apparition_index != -1:
		if use_debug_print:
			print("Button Changed - Device Index: ", device_index, " Apparition: ", apparition_index, " Button Index: ", button_index, " New Value: ", new_button_value)
		on_button_changed.emit(device_index, apparition_index, button_index, new_button_value)
	
