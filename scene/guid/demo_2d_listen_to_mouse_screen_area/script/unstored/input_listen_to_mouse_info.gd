class_name InputListenToMouseInfo
extends Node



signal on_mouse_pixels_lrdt_updated(mouse_position_pixels:Vector2i)
signal on_mouse_percent_lrdt_updated(mouse_position_percents:Vector2)
signal on_mouse_pixels_lrdt_and_screen_size_updated(mouse_position_pixels:Vector2i, screen_pixel_size:Vector2i)

signal on_mouse_format_text_updated_pixel(text_format:String)
signal on_mouse_format_text_updated_percent(text_format:String)
signal on_mouse_format_text_updated_screen_size(text_format:String)


@export var _screen_pixel_size:Vector2i
@export var _mouse_pixel_lrtd_godot:Vector2i
@export var _mouse_pixel_lrdt:Vector2i
@export var _mouse_percent_lrdt:Vector2
@export var _format_mouse_position_pixel:String = "Mouse X: %s pixels, Mouse Y: %s pixels"
@export var _format_mouse_position_percent:String = "Mouse X: %s percents, Mouse Y: %s percents"
@export var _format_screen_size_pixel:String = "Screen Width: %s pixels, Screen Height: %s pixels"


@export_group("Broadcasting")
@export var _node_to_broadcast:Array[Node] = []
@export var _receive_pixels_screen_lrdt_method:String = "push_in_pixels_lrdt_mouse_position_and_size"
@export var _receive_percent_screen_lrdt_method:String = "push_in_percent_lrdt_mouse_position"



func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_screen_pixel_size = Vector2i(get_viewport().size)
		_mouse_pixel_lrtd_godot = Vector2i(event.position)
		_mouse_pixel_lrdt = Vector2i(event.position.x, -(event.position.y-_screen_pixel_size.y))
		_mouse_percent_lrdt = Vector2(event.position.x / _screen_pixel_size.x, 1.0- (event.position.y / _screen_pixel_size.y))

		on_mouse_pixels_lrdt_updated.emit(_mouse_pixel_lrdt)
		on_mouse_percent_lrdt_updated.emit(_mouse_percent_lrdt)
		on_mouse_pixels_lrdt_and_screen_size_updated.emit(_mouse_pixel_lrdt, _screen_pixel_size)

		var text_px = _format_mouse_position_pixel % [_mouse_pixel_lrdt.x, _mouse_pixel_lrdt.y]
		var text_pc = _format_mouse_position_percent % [_mouse_percent_lrdt.x, _mouse_percent_lrdt.y]
		var text_screen_size = _format_screen_size_pixel % [_screen_pixel_size.x, _screen_pixel_size.y]

		on_mouse_format_text_updated_pixel.emit(text_px)
		on_mouse_format_text_updated_percent.emit(text_pc)
		on_mouse_format_text_updated_screen_size.emit(text_screen_size)

		for node in _node_to_broadcast:
			if node!=null and is_instance_valid(node):
				if node.has_method(_receive_pixels_screen_lrdt_method):
					node.call(_receive_pixels_screen_lrdt_method, _mouse_pixel_lrdt, _screen_pixel_size)
				if node.has_method(_receive_percent_screen_lrdt_method):
					node.call(_receive_percent_screen_lrdt_method, _mouse_percent_lrdt)
