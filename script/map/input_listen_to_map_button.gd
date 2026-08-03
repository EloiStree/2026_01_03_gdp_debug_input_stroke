class_name InputListenToMapButton
extends InputAbstractOnOffEmit
@export var _input_map_named=""

func _ready() -> void:
	check_and_notify_value()	


func _process(_delta: float) -> void:
	check_and_notify_value()

func check_and_notify_value():
	if _input_map_named=="":
		return

	if InputMap.has_action(_input_map_named):
		var current_value = Input.is_action_pressed(_input_map_named)
		if current_value != is_on():
			notify_as_changed_state(current_value)
