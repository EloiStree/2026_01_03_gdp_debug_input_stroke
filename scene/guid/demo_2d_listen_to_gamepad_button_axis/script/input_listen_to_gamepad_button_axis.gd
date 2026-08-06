
extends Node

signal on_down_up_with_device_info(device_name: String, device_id: int, button_index: int, pressed: bool)
signal on_changed_with_format_string(text:String)
@export var use_print_debug: bool = true
@export var format_string :="NAME ID TYPE INDEX VALUE"
@export var press_if_true:="+"
@export var press_if_false:="-"
@export var display_button=true
@export var display_axis=true


func _input(event):
	if event is InputEventJoypadButton:
		if display_button:
			var device_name := Input.get_joy_name(event.device)
			if use_print_debug:
				print("Device:", device_name,
					  " ID:", event.device,
					  " Button:", event.button_index,	
					  " Pressed:", event.pressed)
					
			on_down_up_with_device_info.emit(
				"",
				device_name,
				event.device,
				event.button_index,
				event.pressed
			)
			
			var debug_text = format_string
			debug_text= debug_text.replace("VALUE", press_if_true if event.pressed else press_if_false)
			debug_text= debug_text.replace("INDEX", str(event.button_index))
			debug_text= debug_text.replace("TYPE", "B")
			debug_text= debug_text.replace("ID", str(event.device))
			debug_text= debug_text.replace("NAME", str(device_name))
			on_changed_with_format_string.emit((debug_text))
			
	if event is InputEventJoypadMotion:
		if display_axis and abs(event.axis_value)>0.1:
			var device_name := Input.get_joy_name(event.device)
			if use_print_debug:
				print("Device:", device_name,
					  " ID:", event.device,
					  " Button:", event.axis,	
					  " Value:", event.axis_value)
					
			on_down_up_with_device_info.emit(
				"",
				device_name,
				event.device,
				event.axis,
				event.axis_value
			)
			var debug_text = format_string
			debug_text= debug_text.replace("VALUE",str(event.axis_value) )
			debug_text= debug_text.replace("INDEX", str(event.axis))
			debug_text= debug_text.replace("TYPE", "A")
			debug_text= debug_text.replace("ID", str(event.device))
			debug_text= debug_text.replace("NAME", str(device_name))
			on_changed_with_format_string.emit((debug_text))
			
			
