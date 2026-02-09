class_name ListenToDevicesAxisAndButtonsTextDebugger 
extends Node

@export var listen_to_axis_and_buttons:ListenToDevicesAxisAndButtons 

signal on_new_device_name_detected(text:String)
signal on_last_device_name_to_changed(text:String)
signal on_last_device_name_to_have_button_changed(text:String)
signal on_last_device_button_id_to_changed(text:String)
signal on_last_device_axis_id_to_changed(text:String)

signal on_last_device_button_debug_to_changed(text:String)
signal on_last_device_axis_debug_to_changed(text:String)


func _ready() -> void:
	var l = listen_to_axis_and_buttons
	l.on_new_device_tracked.connect(_on_new_device_tracked)
	l.on_axis_changed.connect(_on_axis_changed)
	l.on_button_changed.connect(_on_button_changed)
	l.on_any_event_to_device_reference.connect(_on_any_event_to_device_reference)
	l.on_any_event_to_device_and_manager_reference.connect(_on_any_event_to_device_and_manager_reference)
	l.on_any_button_event_to_device_reference.connect(_on_any_button_event_to_device_reference)

func _on_new_device_tracked(device_index: int, apparition_index: int, device_name: String) -> void:
	on_new_device_name_detected.emit(device_name)

func _on_axis_changed(device_index: int, apparition_index: int, axis_index: int, previous_axis_value: float, new_axis_value: float) -> void:
	var axis_value_str := "%.2f" % new_axis_value
	on_last_device_axis_debug_to_changed.emit("D"+str(device_index)+"IN"+str(apparition_index)+"A"+str(axis_index) + " "+ axis_value_str)
	var device := listen_to_axis_and_buttons.get_device_axis_by_godot_index(device_index, axis_index)
	if device != null:
		on_last_device_axis_id_to_changed.emit(device.get_axis_apparition_string_id_name_with_gamepad_name())

func _on_button_changed(device_index: int, apparition_index: int, button_index: int,  new_button_value: bool) -> void:
	on_last_device_button_debug_to_changed.emit("D"+str(device_index)+"IN"+str(apparition_index)+"B"+str(button_index)+ " "+str(new_button_value))
	var device := listen_to_axis_and_buttons.get_device_button_by_godot_index(device_index, button_index)
	if device != null:
		on_last_device_button_id_to_changed.emit(device.get_button_apparition_string_id_name_with_gamepad_name())

func _on_any_event_to_device_reference(device: ListenToDevicesAxisAndButtons.DeviceTracked) -> void:
	on_last_device_name_to_changed.emit(device.joystick_name)

func _on_any_event_to_device_and_manager_reference(device: ListenToDevicesAxisAndButtons.DeviceTracked, manager: ListenToDevicesAxisAndButtons) -> void:
	pass

func _on_any_button_event_to_device_reference(device: ListenToDevicesAxisAndButtons.DeviceTracked) -> void:
	on_last_device_name_to_have_button_changed.emit(device.joystick_name)
