class_name InputListenToMouseAreaSinglePixels
extends InputAbstractListenToMouseAreaTriggersSingle

@export var _area_border_pixels:InputResourceMouseAreaBorderPixels
@export var _current_is_in_area:bool = false
var _previous_is_in_area:bool = false

var _screen_pixel_size:Vector2i
var _mouse_pixel_lrdt:Vector2i

@export_group("For Debugging")
@export var _check_button:Array[CheckButton] = []


func push_in_pixels_lrdt_mouse_position_and_size_lrdt( mouse_position_pixels_lrdt:Vector2i, screen_pixel_size:Vector2i) -> void:
	_screen_pixel_size = screen_pixel_size
	_mouse_pixel_lrdt = mouse_position_pixels_lrdt

	_previous_is_in_area = _current_is_in_area
	_current_is_in_area = _area_border_pixels.is_mouse_in_area_from_pixels_lrdt(_mouse_pixel_lrdt, _screen_pixel_size)
	if _previous_is_in_area != _current_is_in_area:
		if _current_is_in_area:
			for trigger_name in _area_border_pixels._enter_text_trigger:
				on_area_triggered_enter.emit(trigger_name)
		else:
			for trigger_name in _area_border_pixels._exit_text_trigger:
				on_area_triggered_exit.emit(trigger_name)
		for trigger_name in _area_border_pixels._enter_exit_trigger_boolean_name:
			on_area_triggered_inside_value.emit(trigger_name, _current_is_in_area)
		on_area_value_changed.emit(_current_is_in_area)
		for check_button in _check_button:
			if check_button!=null and is_instance_valid(check_button):
				check_button.set_pressed(_current_is_in_area)
