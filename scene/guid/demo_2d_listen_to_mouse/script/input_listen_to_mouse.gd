class_name InputListenToMouse
extends Node

signal on_scroll_named_action(action_name: String)
signal on_mouse_button_action(action_name: String, is_pressed: bool)

signal on_mouse_state_debug_as_string(text: String)
signal on_mouse_event_received_as_string(text: String)
signal on_mouse_position_changed_as_pixel(position_pixel: Vector2)
signal on_mouse_position_changed_as_percent(position_percent: Vector2)
signal on_mouse_position_changed_as_string(text: String)



signal on_mouse_left_down_changed(is_pressed: bool)
signal on_mouse_middle_down_changed(is_pressed: bool)
signal on_mouse_right_down_changed(is_pressed: bool)
signal on_mouse_side_button_1_down_changed(is_pressed: bool)
signal on_mouse_side_button_2_down_changed(is_pressed: bool)
signal on_mouse_scroll_up_tick()
signal on_mouse_scroll_down_tick()
signal on_mouse_scroll_left_tick()
signal on_mouse_scroll_right_tick()


@export var _mouse_x_y_format_string: String = "Mouse Position: {X}, {Y}, Pixel: {PX}, {PY}"
@export var mouse_event_to_listen: int
@export var use_print_debug: bool = true

@export var _mouse_left_button_pressing:bool = false
@export var _mouse_middle_button_pressing:bool = false
@export var _mouse_right_button_pressing:bool = false
@export var _mouse_side_button_1_pressing:bool = false
@export var _mouse_side_button_2_pressing:bool = false

@export var _last_scroll_up_event_time: float = 0.0
@export var _last_scroll_down_event_time: float = 0.0
@export var _last_scroll_left_event_time: float = 0.0
@export var _last_scroll_right_event_time: float = 0.0

@export var _last_scroll_event_count_up: int = 0.0
@export var _last_scroll_event_count_down: int = 0.0
@export var _last_scroll_event_count_left:  int = 0.0
@export var _last_scroll_event_count_right:  int = 0.0

@export var _mouse_position_over_screen: Vector2 = Vector2.ZERO
@export var _mouse_position_over_screen_percent: Vector2 = Vector2.ZERO
@export var _mouse_space_width: float = 0.0
@export var _mouse_space_height: float = 0.0

func get_time_utc() -> float:
	return Time.get_unix_time_from_system() * 1000.0

func _input(event: InputEvent) -> void:

	if event is InputEventMouseMotion and not event is InputEventMouseButton:
		var changed_position: Vector2 = event.position	
		var is_position_changed: bool = changed_position != _mouse_position_over_screen
		_mouse_position_over_screen = event.position
		_mouse_space_width = get_viewport().get_visible_rect().size.x
		_mouse_space_height = get_viewport().get_visible_rect().size.y
		_mouse_position_over_screen_percent = Vector2(
			changed_position.x / _mouse_space_width,
			changed_position.y / _mouse_space_height
		)
		if is_position_changed:

			on_mouse_position_changed_as_pixel.emit(changed_position)
			on_mouse_position_changed_as_percent.emit(_mouse_position_over_screen_percent)
			on_mouse_position_changed_as_string.emit(_mouse_x_y_format_string.format({
				"X": _mouse_position_over_screen.x,
				"Y": _mouse_position_over_screen.y,
				"PX": _mouse_position_over_screen_percent.x,
				"PY": _mouse_position_over_screen_percent.y
			}))

	if event is InputEventMouseButton:
		if use_print_debug:
			print("Mouse Event: ", event)
			print("Mouse Position: ", event.position)
			print("Mouse Button Index: ", event.button_index)
			
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if _mouse_left_button_pressing != event.pressed:
				_mouse_left_button_pressing = event.pressed
				on_mouse_left_down_changed.emit(_mouse_left_button_pressing)
			_mouse_left_button_pressing = event.pressed
			on_mouse_button_action.emit("MOUSE_BUTTON_LEFT", _mouse_left_button_pressing)
			on_mouse_event_received_as_string.emit("Mouse Left Button Event: " + str(event.pressed))
		elif event.button_index == MouseButton.MOUSE_BUTTON_MIDDLE:
			if _mouse_middle_button_pressing != event.pressed:
				_mouse_middle_button_pressing = event.pressed
				on_mouse_middle_down_changed.emit(_mouse_middle_button_pressing)
			_mouse_middle_button_pressing = event.pressed
			on_mouse_button_action.emit("MOUSE_BUTTON_MIDDLE", _mouse_middle_button_pressing)
			on_mouse_event_received_as_string.emit("Mouse Middle Button Event: " + str(event.pressed))
		elif event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			if _mouse_right_button_pressing != event.pressed:
				_mouse_right_button_pressing = event.pressed
				on_mouse_right_down_changed.emit(_mouse_right_button_pressing)
			_mouse_right_button_pressing = event.pressed
			on_mouse_button_action.emit("MOUSE_BUTTON_RIGHT", _mouse_right_button_pressing)
			on_mouse_event_received_as_string.emit("Mouse Right Button Event: " + str(event.pressed))



		elif event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_LEFT:
			_last_scroll_left_event_time = get_time_utc()
			_last_scroll_event_count_left+=1
			on_mouse_scroll_left_tick.emit()
			on_mouse_scroll_left_tick.emit("MOUSE_SCROLL_LEFT")
			on_mouse_event_received_as_string.emit("Mouse Scroll Left Event")
		elif event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_UP:
			_last_scroll_up_event_time = get_time_utc()
			_last_scroll_event_count_up+=1
			on_mouse_scroll_up_tick.emit()
			on_mouse_scroll_up_tick.emit("MOUSE_SCROLL_UP")
			on_mouse_event_received_as_string.emit("Mouse Scroll Up Event")
		elif event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_RIGHT:
			_last_scroll_right_event_time = get_time_utc()
			_last_scroll_event_count_right+=1
			on_mouse_scroll_right_tick.emit()
			on_mouse_scroll_right_tick.emit("MOUSE_SCROLL_RIGHT")
			on_mouse_event_received_as_string.emit("Mouse Scroll Right Event")
		elif event.button_index == MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
			_last_scroll_down_event_time = get_time_utc()
			_last_scroll_event_count_down+=1
			on_mouse_scroll_down_tick.emit()
			on_mouse_scroll_down_tick.emit("MOUSE_SCROLL_DOWN")
			on_mouse_event_received_as_string.emit("Mouse Scroll Down Event")


		elif event.button_index == MouseButton.MOUSE_BUTTON_XBUTTON1:
			if _mouse_side_button_1_pressing != event.pressed:
				_mouse_side_button_1_pressing = event.pressed
				on_mouse_side_button_1_down_changed.emit(_mouse_side_button_1_pressing)
			_mouse_side_button_1_pressing = event.pressed
			on_mouse_button_action.emit("MOUSE_BUTTON_XBUTTON1", _mouse_side_button_1_pressing)
			on_mouse_event_received_as_string.emit("Mouse Side Button 1 Event: " + str(event.pressed))
		elif event.button_index == MouseButton.MOUSE_BUTTON_XBUTTON2:
			if _mouse_side_button_2_pressing != event.pressed:
				_mouse_side_button_2_pressing = event.pressed
				on_mouse_side_button_2_down_changed.emit(_mouse_side_button_2_pressing)
			_mouse_side_button_2_pressing = event.pressed
			on_mouse_button_action.emit("MOUSE_BUTTON_XBUTTON2", _mouse_side_button_2_pressing)
			on_mouse_event_received_as_string.emit("Mouse Side Button 2 Event: " + str(event.pressed))

	var text: String = _mouse_state_debug_format_string.format({
		"bl": _mouse_left_button_pressing,
		"bm": _mouse_middle_button_pressing,
		"br": _mouse_right_button_pressing,
		"x1": _mouse_side_button_1_pressing,
		"x2": _mouse_side_button_2_pressing,
		"s_up": str(_last_scroll_event_count_up),
		"s_down": str(_last_scroll_event_count_down),
		"s_left": str(_last_scroll_event_count_left),
		"s_right": str(_last_scroll_event_count_right)
	})
	on_mouse_state_debug_as_string.emit(text)


@export_multiline() var _mouse_state_debug_format_string: String = """
ML: {bl}, MM: {bm}, MR: {br}, BX1: {x1}, BX2: {x2}
U {s_up}, D {s_down}
L {s_left}, R {s_right}"""
