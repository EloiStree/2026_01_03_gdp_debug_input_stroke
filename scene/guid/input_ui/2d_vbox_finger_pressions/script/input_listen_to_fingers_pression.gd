class_name InputListenScreenFingersPression
extends Node

signal on_finger_n_pression_update(finger_index: int, value: float)
signal on_finger_0_pression_update(value: float)
signal on_finger_1_pression_update(value: float)
signal on_finger_2_pression_update(value: float)
signal on_finger_3_pression_update(value: float)
signal on_finger_4_pression_update(value: float)


@export_group("Debug Sliders")
@export var _debug_pression_sliders: Array[Slider] = []
@export_group("Debug Value")
@export var _fingers_pression: Array[float] = [0,0,0,0,0,0,0,0,0,0]
@export var _fingers_position: Array[Vector2] = [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO]
@export var _fingers_is_detected: Array[bool] = [false, false, false, false, false, false, false, false, false, false]


func _update_debug_sliders() -> void:
	for i in range(10):
		if i < _debug_pression_sliders.size():
			_debug_pression_sliders[i].value = _fingers_pression[i]

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var event_typed: InputEventScreenTouch = event
		if event_typed.pressed:
			_add_finger(event_typed.index, event_typed.position, event_typed.pressure)
		else:
			_remove_finger(event_typed.index)

	elif event is InputEventScreenDrag:
		var event_typed: InputEventScreenDrag = event
		_update_finger(event_typed.index, event_typed.position, event_typed.pressure)

func _add_finger(index: int, position: Vector2, pressure: float) -> void:
	if index < 10:
		_fingers_pression[index] = pressure
		_fingers_position[index] = position
		_fingers_is_detected[index] = true
		on_finger_n_pression_update.emit(index, pressure)
		_update_debug_sliders()

func _update_finger(index: int, position: Vector2, pressure: float) -> void:
	if index < 10:
		_fingers_pression[index] = pressure
		_fingers_position[index] = position
		_fingers_is_detected[index] = true
		on_finger_n_pression_update.emit(index, pressure)
		_update_debug_sliders()

func _remove_finger(index: int) -> void:
	if index < 10:
		_fingers_pression[index] = 0
		_fingers_position[index] = Vector2.ZERO
		_fingers_is_detected[index] = false
		on_finger_n_pression_update.emit(index, 0)
		_update_debug_sliders()
