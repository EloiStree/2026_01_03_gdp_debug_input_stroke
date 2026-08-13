class_name InputListenToKeyboardCOsCtrlShiftAlt
extends Node

signal on_control_changed(is_on:bool)
signal on_shift_changed(is_on:bool)
signal on_alt_changed(is_on:bool)
signal on_os_key_changed(is_on:bool)
signal on_value_changed_as_debug_string(value_as_string:String)
signal on_changed(is_on:bool)

@export var required_control_key: bool = false
@export var required_alt_key: bool= false
@export var required_shift_key: bool= false
@export var required_os_key: bool= false
@export var use_print_debug: bool = true

@export_group("Debug")
@export var is_shift_there_last:bool
@export var is_alt_there_last:bool
@export var is_control_there_last:bool
@export var is_os_there_last:bool
var is_on_last: bool = false



func _notification(what):
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		print("Lost focus!")
		is_os_there_last = false
		is_control_there_last = false
		on_os_key_changed.emit(false)
		on_control_changed.emit(false)
		on_shift_changed.emit(false)
		on_changed.emit(false)
		_notify_changed_as_debug_string(false, false, false, false)

	elif what == NOTIFICATION_WM_WINDOW_FOCUS_IN:
		print("Gained focus!")




func _input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		var key_event := event as InputEventKey
		var is_shift_there := key_event.shift_pressed
		var is_alt_there := key_event.alt_pressed
		var is_control_there := key_event.ctrl_pressed
		var is_os_there := key_event.meta_pressed

		# Modifier flags on release events are platform-dependent.
		if key_event.keycode == KEY_SHIFT:
			is_shift_there = key_event.is_pressed()
		elif key_event.keycode == KEY_ALT:
			is_alt_there = key_event.is_pressed()
		elif key_event.keycode == KEY_CTRL:
			is_control_there = key_event.is_pressed()
		elif key_event.keycode == KEY_META:
			is_os_there = key_event.is_pressed()
		
		var shift_changed :bool= is_shift_there !=is_shift_there_last
		var alt_changed :bool= is_alt_there !=is_alt_there_last
		var control_changed :bool= is_control_there !=is_control_there_last
		var os_changed :bool= is_os_there != is_os_there_last

		
				
		is_shift_there_last=is_shift_there
		is_alt_there_last=is_alt_there
		is_control_there_last=is_control_there
		is_os_there_last=is_os_there
		
		if shift_changed :
			on_shift_changed.emit(is_shift_there)	
		if alt_changed :
			on_alt_changed.emit(is_alt_there)	
		if control_changed :
			on_control_changed.emit(is_control_there)		
		if os_changed:
			on_os_key_changed.emit(is_os_there)
			
		if use_print_debug:
			print("Ctrl/Alt/Shift - Ctrl: %s, Alt: %s, Shift: %s" % [is_control_there, is_alt_there, is_shift_there])
		
		_notify_changed_as_debug_string(is_os_there, is_control_there, is_alt_there, is_shift_there)
			
		var is_on := (required_shift_key == is_shift_there) and (required_alt_key == is_alt_there) and (required_control_key == is_control_there) and (required_os_key == is_os_there)
		if is_on != is_on_last:
			is_on_last = is_on
			on_changed.emit(is_on)


func _notify_changed_as_debug_string(is_os_there: bool, is_control_there: bool, is_alt_there: bool, is_shift_there: bool) -> void:
	on_value_changed_as_debug_string.emit("OS: %s Ctrl: %s, Alt: %s, Shift: %s" % [is_os_there, is_control_there, is_alt_there, is_shift_there])
			
