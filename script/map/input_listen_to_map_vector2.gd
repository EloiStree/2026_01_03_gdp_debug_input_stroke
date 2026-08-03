class_name InputListenToMapVector2
extends Node

signal on_float_value_updated(value: Vector2)
signal on_float_value_changed(value: Vector2)

@export var _input_map_negative_horizontal := ""
@export var _input_map_positive_horizontal := ""
@export var _input_map_negative_vertical := ""
@export var _input_map_positive_vertical := ""


@export_group("Debug")
@export var _last_value_fetched: Vector2 = Vector2.ZERO

@export var _last_right_value: float = 0.0
@export var _last_left_value: float = 0.0
@export var _last_up_value: float = 0.0
@export var _last_down_value: float = 0.0


func _ready() -> void:
	check_and_notify_value()


func _process(_delta: float) -> void:
	check_and_notify_value()


func check_and_notify_value():
	if _input_map_negative_horizontal == "" or _input_map_positive_horizontal == "" or _input_map_negative_vertical == "" or _input_map_positive_vertical == "":
		return

	if InputMap.has_action(_input_map_negative_horizontal):
		_last_left_value = Input.get_action_strength(_input_map_negative_horizontal)

	if InputMap.has_action(_input_map_positive_horizontal):
		_last_right_value = Input.get_action_strength(_input_map_positive_horizontal)

	if InputMap.has_action(_input_map_negative_vertical):
		_last_down_value = Input.get_action_strength(_input_map_negative_vertical)

	if InputMap.has_action(_input_map_positive_vertical):
		_last_up_value = Input.get_action_strength(_input_map_positive_vertical)

	var current_value := Vector2(_last_right_value - _last_left_value, _last_up_value - _last_down_value)
	var value_changed := current_value != _last_value_fetched
	_last_value_fetched = current_value
	if value_changed:
		on_float_value_changed.emit(current_value)
	on_float_value_updated.emit(current_value)
