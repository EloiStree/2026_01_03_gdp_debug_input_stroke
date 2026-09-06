class_name InputListenToMouseAreaSingleRectangle
extends InputAbstractListenToMouseAreaTriggersSingle

@export var _area_corner_percent:InputResourceMouseAreaDirectionFromCornerRectangle

@export var _current_is_in_area:bool = false
var _previous_is_in_area:bool = false


@export_group("For Debugging")
@export var _check_button:Array[CheckButton] = []



func push_in_percent_lrdt_mouse_position_lrdt(mouse_position_percent_lrdt:Vector2) -> void:
	_previous_is_in_area = _current_is_in_area
	_current_is_in_area = _area_corner_percent.is_mouse_in_area_from_percent_lrdt(mouse_position_percent_lrdt)
	if _previous_is_in_area != _current_is_in_area:
		if _current_is_in_area:
			for trigger_name in _area_corner_percent._enter_text_trigger:
				on_area_triggered_enter.emit(trigger_name)
		else:
			for trigger_name in _area_corner_percent._exit_text_trigger:
				on_area_triggered_exit.emit(trigger_name)
		for trigger_name in _area_corner_percent._enter_exit_trigger_boolean_name:
			on_area_triggered_inside_value.emit(trigger_name, _current_is_in_area)
		on_area_value_changed.emit(_current_is_in_area)
		for check_button in _check_button:
			if check_button!=null and is_instance_valid(check_button):
				check_button.set_pressed(_current_is_in_area)
