class_name InputListenToMouseArea
extends InputAbstractListenToMouseAreaTriggers

@export var _area_border_percent:Array[InputResourceMouseAreaBorderPercent] = []
@export var _area_border_pixels:Array[InputResourceMouseAreaBorderPixels] = []
@export var _area_corner_percent:Array[InputResourceMouseAreaDirectionFromCorner] = []
@export var _area_rect_percent:Array[InputListenToMouseAreaSingleRectangle] = []

var _dictionary_to_is_in_area_border_percent:Dictionary[ InputResourceMouseAreaBorderPercent,bool] = {}
var _dictionary_to_is_in_area_border_pixels:Dictionary[ InputResourceMouseAreaBorderPixels,bool] = {}
var _dictionary_to_is_in_area_corner_percent:Dictionary[ InputResourceMouseAreaDirectionFromCorner,bool] = {}
var _dictionary_to_is_in_area_rect_percent:Dictionary[ InputListenToMouseAreaSingleRectangle,bool] = {}


@export var _screen_pixel_size:Vector2i
@export var _mouse_pixel_lrdt:Vector2i
@export var _mouse_percent_lrdt:Vector2



func push_in_percent_lrdt_mouse_position(mouse_position_percent_lrdt:Vector2) -> void:
	_mouse_percent_lrdt = mouse_position_percent_lrdt

	
	for area in _area_border_percent:
			var is_in_area = area.is_mouse_in_area_from_percents(_mouse_percent_lrdt)
			if _dictionary_to_is_in_area_border_percent.has(area):
				var value_changed:bool = _dictionary_to_is_in_area_border_percent[area] != is_in_area
				if value_changed:
					_dictionary_to_is_in_area_border_percent[area] = is_in_area
					if is_in_area:
						
						for trigger_name in area._enter_text_trigger:
							on_area_triggered_enter.emit(trigger_name)
					else:
						for trigger_name in area._exit_text_trigger:
							on_area_triggered_exit.emit(trigger_name)
					for trigger_name in area._enter_exit_trigger_boolean_name:
						on_area_triggered_inside_value.emit(trigger_name, is_in_area)
			else:
				_dictionary_to_is_in_area_border_percent[area] = is_in_area
	
	for area in _area_corner_percent:
		var is_in_area = area.is_mouse_in_area_from_percents(_mouse_percent_lrdt)
		if _dictionary_to_is_in_area_corner_percent.has(area):
			var value_changed:bool = _dictionary_to_is_in_area_corner_percent[area] != is_in_area
			if value_changed:
				_dictionary_to_is_in_area_corner_percent[area] = is_in_area
				if is_in_area:
					for trigger_name in area._enter_text_trigger:
						on_area_triggered_enter.emit(trigger_name)
				else:
					for trigger_name in area._exit_text_trigger:
						on_area_triggered_exit.emit(trigger_name)
				for trigger_name in area._enter_exit_trigger_boolean_name:
					on_area_triggered_inside_value.emit(trigger_name, is_in_area)
		else:
			_dictionary_to_is_in_area_corner_percent[area] = is_in_area

	for area in _area_rect_percent:
		var is_in_area = area.is_mouse_in_area_from_percents(_mouse_percent_lrdt)
		if _dictionary_to_is_in_area_rect_percent.has(area):
			var value_changed:bool = _dictionary_to_is_in_area_rect_percent[area] != is_in_area
			if value_changed:
				_dictionary_to_is_in_area_rect_percent[area] = is_in_area
				if is_in_area:
					for trigger_name in area._enter_text_trigger:
						on_area_triggered_enter.emit(trigger_name)
				else:
					for trigger_name in area._exit_text_trigger:
						on_area_triggered_exit.emit(trigger_name)
				for trigger_name in area._enter_exit_trigger_boolean_name:
					on_area_triggered_inside_value.emit(trigger_name, is_in_area)
		else:
			_dictionary_to_is_in_area_rect_percent[area] = is_in_area

func push_in_pixels_lrdt_mouse_position_and_size(mouse_position_pixels_lrdt:Vector2i, screen_pixel_size:Vector2i) -> void:
	_screen_pixel_size = screen_pixel_size
	_mouse_pixel_lrdt = mouse_position_pixels_lrdt

	for area in _area_border_pixels:
		var is_in_area = area.is_mouse_in_area_from_pixels(_mouse_pixel_lrdt, _screen_pixel_size)
		if _dictionary_to_is_in_area_border_pixels.has(area):
			var value_changed:bool = _dictionary_to_is_in_area_border_pixels[area] != is_in_area
			if value_changed:
				_dictionary_to_is_in_area_border_pixels[area] = is_in_area
				if is_in_area:
					for trigger_name in area._enter_text_trigger:
						on_area_triggered_enter.emit(trigger_name)
				else:
					for trigger_name in area._exit_text_trigger:
						on_area_triggered_exit.emit(trigger_name)
				for trigger_name in area._enter_exit_trigger_boolean_name:
					on_area_triggered_inside_value.emit(trigger_name, is_in_area)
		else:
			_dictionary_to_is_in_area_border_pixels[area] = is_in_area
