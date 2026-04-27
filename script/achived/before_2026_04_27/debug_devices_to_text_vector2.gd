class_name DebugDevicesToTextVector2 extends Node
@export var ui_text_node: Label = null
@export var devise_id_name:="Xbox"
func _ready() -> void:
	if ui_text_node == null:
		push_error("ui_text_node is not assigned.")

func set_text_for_vector2(joy_id: int, gamepad_index: int, label_name: String, value_joystick: Vector2) -> void:
	ui_text_node.text = "%s %d (gamepad %d): %s is (%.2f, %.2f)" % [devise_id_name,joy_id + 1, gamepad_index, label_name, value_joystick.x, value_joystick.y]
