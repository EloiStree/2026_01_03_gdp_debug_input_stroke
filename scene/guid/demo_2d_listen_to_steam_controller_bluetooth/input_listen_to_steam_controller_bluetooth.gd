class_name ListenToSteamControllerBluetooth
extends Node


signal on_menu_left_changed(is_pressing: bool)
signal on_menu_right_and_button_b_changed(is_pressing: bool)
signal on_track_pad_click_and_button_a_changed(is_pressing: bool)
signal on_trigger_left_changed(is_pressing: bool)
signal on_trigger_right_changed(is_pressing: bool)
signal on_arrow_state_changed_as_boolean(
	up: bool,
	right: bool,
	down: bool,
	left: bool
)
signal on_arrow_state_changed_as_vector2(direction_xy: Vector2)
signal on_mouse_position_in_pixel_lrdt(position: Vector2)
signal on_mouse_position_in_screen_percent_lrdt(position: Vector2)


## -------------------------------------------------------------------------
## MOUSE / TRIGGER STATE
## -------------------------------------------------------------------------

@export var _left_trigger_is_mouse_right: bool = false
@export var _right_trigger_is_mouse_left: bool = false

@export var _track_pad_right_as_mouse_position_pixel: Vector2i = Vector2i.ZERO
@export var _track_pad_right_as_mouse_position_percent: Vector2 = Vector2.ZERO
@export var _left_pad_click_as_mouse_left_click: bool = false

@export var _button_a_as_enter_key: bool = false
@export var _button_b_as_escape_key: bool = false


## -------------------------------------------------------------------------
## LEFT TRACK PAD SCROLL
##
## These are the values you want your game to receive when the Steam
## controller generates mouse-wheel events.
## -------------------------------------------------------------------------

@export var _track_pad_left_as_scroll_left_value: float = 1.0
@export var _track_pad_left_as_scroll_right_value: float = 1.0
@export var _track_pad_left_as_scroll_up_value: float = 1.0
@export var _track_pad_left_as_scroll_down_value: float = 1.0


## -------------------------------------------------------------------------
## ARROWS
## -------------------------------------------------------------------------

@export var _arrows_as_keyboard_arrow_up: bool = false
@export var _arrows_as_keyboard_arrow_right: bool = false
@export var _arrows_as_keyboard_arrow_down: bool = false
@export var _arrows_as_keyboard_arrow_left: bool = false

@export var _arrows_parse_to_vector2: Vector2 = Vector2.ZERO


## -------------------------------------------------------------------------
## MENU
## -------------------------------------------------------------------------

@export var _menu_left_as_keyboard_tab: bool = false
@export var _menu_right_as_keyboard_escape: bool = false


## -------------------------------------------------------------------------
## SCROLL TRACKING
## -------------------------------------------------------------------------

@export var _last_scroll_up_event_time: float = 0.0
@export var _last_scroll_down_event_time: float = 0.0
@export var _last_scroll_left_event_time: float = 0.0
@export var _last_scroll_right_event_time: float = 0.0

@export var _last_scroll_event_count_up: int = 0
@export var _last_scroll_event_count_down: int = 0
@export var _last_scroll_event_count_left: int = 0
@export var _last_scroll_event_count_right: int = 0


## -------------------------------------------------------------------------
## TIME
## -------------------------------------------------------------------------

func get_time_utc() -> float:
	return Time.get_unix_time_from_system() * 1000.0


signal on_control_as_debug_text_at_input_updated(text:String)
func get_debug_text() -> String:
	var text := ""

	text += "=== Steam Controller Bluetooth ===\n"
	text +="Screen %s\n" % DisplayServer.screen_get_size()
	text +="Window %s\n" % DisplayServer.window_get_size()
	text +="Viewport pixel %s\n" % get_viewport().get_visible_rect().size
	text += "Left Trigger / Mouse Right: %s\n" % _left_trigger_is_mouse_right
	text += "Right Trigger / Mouse Left: %s\n" % _right_trigger_is_mouse_left
	text += "Right Trackpad Pixel: %s\n" % _track_pad_right_as_mouse_position_pixel
	text += "Right Trackpad Percent: %s\n" % _track_pad_right_as_mouse_position_percent
	text += "Left Trackpad Click / Mouse Left: %s\n" % _left_pad_click_as_mouse_left_click
	text += "A / Enter: %s  " % _button_a_as_enter_key
	text += "B / Escape: %s\n" % _button_b_as_escape_key
	text += "Menu Left / Tab: %s  " % _menu_left_as_keyboard_tab
	text += "Menu Right / Escape: %s\n" % _menu_right_as_keyboard_escape
	text += "Up: %s  " % _arrows_as_keyboard_arrow_up
	text += "Right: %s  " % _arrows_as_keyboard_arrow_right
	text += "Down: %s  " % _arrows_as_keyboard_arrow_down
	text += "Left: %s  " % _arrows_as_keyboard_arrow_left
	text += "Vector: %s \n" % _arrows_parse_to_vector2
	text += "Up Count: %d | Last: %.0f\n" % [
		_last_scroll_event_count_up,
		_last_scroll_up_event_time
	]
	text += "Down Count: %d | Last: %.0f\n" % [
		_last_scroll_event_count_down,
		_last_scroll_down_event_time
	]
	text += "Left Count: %d | Last: %.0f\n" % [
		_last_scroll_event_count_left,
		_last_scroll_left_event_time
	]
	text += "Right Count: %d | Last: %.0f\n" % [
		_last_scroll_event_count_right,
		_last_scroll_right_event_time
	]

	return text
## -------------------------------------------------------------------------
## INPUT
## -------------------------------------------------------------------------

func _input(event: InputEvent) -> void:
	var update=false
	# ----------------------------------------------------------------------
	# MOUSE MOTION
	# ----------------------------------------------------------------------

	if event is InputEventMouseMotion:
		_update_mouse_position(event)
		update=true


	# ----------------------------------------------------------------------
	# MOUSE BUTTONS
	# ----------------------------------------------------------------------

	elif event is InputEventMouseButton:
		_process_mouse_button(event)
		update=true

	# ----------------------------------------------------------------------
	# KEYBOARD
	# ----------------------------------------------------------------------

	elif event is InputEventKey:
		_process_keyboard(event)
		update=true	
	
	if update:
		var t = get_debug_text()
		on_control_as_debug_text_at_input_updated.emit(t)

## -------------------------------------------------------------------------
## MOUSE POSITION
## -------------------------------------------------------------------------

func _update_mouse_position(event: InputEventMouseMotion) -> void:

	#var window_size: Vector2 = DisplayServer.window_get_size()
	var window_size: Vector2 = get_viewport().get_visible_rect().size

	var changed_position: Vector2 = event.position
	var changed_position_percent: Vector2 = event.position / get_viewport().get_visible_rect().size

	# Convert Godot's normal top-left origin:
	#
	#     (0, 0)
	#       ┌───────────────► X
	#       │
	#       │
	#       ▼
	#       Y
	#
	# into left-right / down-top coordinates:
	#
	#       ▲ Y
	#       │
	#       │
	#     (0, height)
	#
	# The original code used mouse_space_width here.
	# That should be mouse_space_height.
	changed_position.y = window_size.y -changed_position.y
	changed_position_percent.y = 1.0-changed_position_percent.y
	_track_pad_right_as_mouse_position_pixel = Vector2i(
		roundi(changed_position.x),
		roundi(changed_position.y)
	)

	_track_pad_right_as_mouse_position_percent = changed_position_percent
	

	on_mouse_position_in_pixel_lrdt.emit(
		changed_position
	)

	on_mouse_position_in_screen_percent_lrdt.emit(
		_track_pad_right_as_mouse_position_percent
	)


## -------------------------------------------------------------------------
## MOUSE BUTTON PROCESSING
## -------------------------------------------------------------------------

func _process_mouse_button(event: InputEventMouseButton) -> void:

	var pressed: bool = event.pressed

	match event.button_index:

		MouseButton.MOUSE_BUTTON_LEFT:
			_set_right_trigger_is_mouse_left(pressed)
			_set_left_pad_click_as_mouse_left_click(pressed)

		MouseButton.MOUSE_BUTTON_RIGHT:
			_set_left_trigger_is_mouse_right(pressed)

		MouseButton.MOUSE_BUTTON_WHEEL_UP:
			_process_scroll_up()

		MouseButton.MOUSE_BUTTON_WHEEL_DOWN:
			_process_scroll_down()

		MouseButton.MOUSE_BUTTON_WHEEL_LEFT:
			_process_scroll_left()

		MouseButton.MOUSE_BUTTON_WHEEL_RIGHT:
			_process_scroll_right()


## -------------------------------------------------------------------------
## LEFT MOUSE BUTTON
## -------------------------------------------------------------------------

func _set_right_trigger_is_mouse_left(value: bool) -> void:

	if _right_trigger_is_mouse_left == value:
		return

	_right_trigger_is_mouse_left = value

	on_trigger_right_changed.emit(value)


func _set_left_pad_click_as_mouse_left_click(value: bool) -> void:

	if _left_pad_click_as_mouse_left_click == value:
		return

	_left_pad_click_as_mouse_left_click = value

	on_track_pad_click_and_button_a_changed.emit(value)


## -------------------------------------------------------------------------
## RIGHT MOUSE BUTTON
## -------------------------------------------------------------------------

func _set_left_trigger_is_mouse_right(value: bool) -> void:

	if _left_trigger_is_mouse_right == value:
		return

	_left_trigger_is_mouse_right = value

	on_trigger_left_changed.emit(value)


## -------------------------------------------------------------------------
## SCROLL
## -------------------------------------------------------------------------

func _process_scroll_up() -> void:

	_last_scroll_up_event_time = get_time_utc()
	_last_scroll_event_count_up += 1


func _process_scroll_down() -> void:

	_last_scroll_down_event_time = get_time_utc()
	_last_scroll_event_count_down += 1


func _process_scroll_left() -> void:

	_last_scroll_left_event_time = get_time_utc()
	_last_scroll_event_count_left += 1


func _process_scroll_right() -> void:

	_last_scroll_right_event_time = get_time_utc()
	_last_scroll_event_count_right += 1


## -------------------------------------------------------------------------
## KEYBOARD
## -------------------------------------------------------------------------

func _process_keyboard(event: InputEventKey) -> void:

	# Ignore key-repeat events.
	if event.echo:
		return

	var pressed: bool = event.pressed

	match event.keycode:

		KEY_TAB:
			_set_menu_left(pressed)

		KEY_ESCAPE:
			_set_button_b(pressed)

		KEY_ENTER, KEY_KP_ENTER:
			_set_button_a(pressed)

		KEY_UP:
			_set_arrow_up(pressed)

		KEY_RIGHT:
			_set_arrow_right(pressed)

		KEY_DOWN:
			_set_arrow_down(pressed)

		KEY_LEFT:
			_set_arrow_left(pressed)


## -------------------------------------------------------------------------
## BUTTON A
## -------------------------------------------------------------------------

func _set_button_a(value: bool) -> void:

	if _button_a_as_enter_key == value:
		return

	_button_a_as_enter_key = value

	on_track_pad_click_and_button_a_changed.emit(value)


## -------------------------------------------------------------------------
## BUTTON B
## -------------------------------------------------------------------------

func _set_button_b(value: bool) -> void:

	if _button_b_as_escape_key == value:
		return

	_button_b_as_escape_key = value
	_menu_right_as_keyboard_escape=value

	on_menu_right_and_button_b_changed.emit(value)


## -------------------------------------------------------------------------
## MENU LEFT / TAB
## -------------------------------------------------------------------------

func _set_menu_left(value: bool) -> void:

	if _menu_left_as_keyboard_tab == value:
		return

	_menu_left_as_keyboard_tab = value

	on_menu_left_changed.emit(value)


## -------------------------------------------------------------------------
## ARROWS
## -------------------------------------------------------------------------

func _set_arrow_up(value: bool) -> void:

	if _arrows_as_keyboard_arrow_up == value:
		return

	_arrows_as_keyboard_arrow_up = value
	_update_arrow_vector()


func _set_arrow_right(value: bool) -> void:

	if _arrows_as_keyboard_arrow_right == value:
		return

	_arrows_as_keyboard_arrow_right = value
	_update_arrow_vector()


func _set_arrow_down(value: bool) -> void:

	if _arrows_as_keyboard_arrow_down == value:
		return

	_arrows_as_keyboard_arrow_down = value
	_update_arrow_vector()


func _set_arrow_left(value: bool) -> void:

	if _arrows_as_keyboard_arrow_left == value:
		return

	_arrows_as_keyboard_arrow_left = value
	_update_arrow_vector()


func _update_arrow_vector() -> void:

	var direction := Vector2(
		float(_arrows_as_keyboard_arrow_right)
		- float(_arrows_as_keyboard_arrow_left),

		float(_arrows_as_keyboard_arrow_down)
		- float(_arrows_as_keyboard_arrow_up)
	)

	_arrows_parse_to_vector2 = direction

	on_arrow_state_changed_as_boolean.emit(
		_arrows_as_keyboard_arrow_up,
		_arrows_as_keyboard_arrow_right,
		_arrows_as_keyboard_arrow_down,
		_arrows_as_keyboard_arrow_left
	)

	on_arrow_state_changed_as_vector2.emit(
		_arrows_parse_to_vector2
	)
