class_name InputTriggerTextActionsFromEnterExitResource
extends Node
signal on_action_triggered(text_action: String)
@export var _action_to_trigger: InputResourceEnterExitTextAction = InputResourceEnterExitTextAction.new()

func trigger_enter_actions() -> void:
	if _action_to_trigger.has_action_on_enter():
		for action in _action_to_trigger.get_actions_on_enter():
			emit_signal("on_action_triggered", action)

func trigger_exit_actions() -> void:
	if _action_to_trigger.has_action_on_exit():
		for action in _action_to_trigger.get_actions_on_exit():
			emit_signal("on_action_triggered", action)

func trigger_actions_from_boolean(is_enter: bool) -> void:
	if is_enter:
		trigger_enter_actions()
	else:
		trigger_exit_actions()
		
		
func trigger_actions_from_inverse_of_boolean(value: bool) -> void:
	if not value:
		trigger_enter_actions()
	else:
		trigger_exit_actions()



#region ON CHANGED
func trigger_actions_on_changed_if_value_is_true(previous_value: bool, current_value: bool) -> void:
	if not previous_value and current_value:
		trigger_enter_actions()
	elif previous_value and not current_value:
		trigger_exit_actions()

func trigger_actions_on_changed_if_value_is_false(previous_value: bool, current_value: bool) -> void:
	if not previous_value and current_value:
		trigger_exit_actions()
	elif previous_value and not current_value:
		trigger_enter_actions()




func trigger_actions_on_changed_from_float_threshold_n_1(previous_value: float, current_value: float, threshold:float) -> void:
	if previous_value <= threshold and current_value > threshold:
		trigger_enter_actions()
	elif previous_value > threshold and current_value <= threshold:
		trigger_exit_actions()

func trigger_actions_on_changed_from_float_threshold_0_5_to_one(previous_value: float, current_value: float) -> void:
	trigger_actions_on_changed_from_float_threshold_n_1(previous_value, current_value, 0.5)

func trigger_actions_on_changed_from_float_threshold_0_1_to_one(previous_value: float, current_value: float) -> void:
	trigger_actions_on_changed_from_float_threshold_n_1(previous_value, current_value, 0.1)

func trigger_actions_on_changed_from_float_threshold_0_9_to_one(previous_value: float, current_value: float) -> void:
	trigger_actions_on_changed_from_float_threshold_n_1(previous_value, current_value, 0.9)


func trigger_actions_on_changed_from_integer_under_zero(previous_value:int, current_value:int) -> void:
	trigger_actions_from_boolean(current_value < 0 and previous_value >= 0)

func trigger_actions_on_changed_from_integer_over_zero(previous_value:int, current_value:int) -> void:
	trigger_actions_from_boolean(current_value > 0 and previous_value <= 0)

func trigger_actions_on_changed_from_integer_equal_zero(previous_value:int, current_value:int) -> void:
	trigger_actions_from_boolean(current_value == 0 and previous_value != 0)

func trigger_actions_on_changed_from_integer_not_equal_zero(previous_value:int, current_value:int) -> void:
	trigger_actions_from_boolean(current_value != 0 and previous_value == 0)



#endregion
#region TRIGGER WITHOUT CHECK CHANGE





func trigger_actions_if_value_is_true(value: bool) -> void:
	if value:
		trigger_enter_actions()
	else:
		trigger_exit_actions()

func trigger_actions_if_value_is_false(value: bool) -> void:
	if not value:
		trigger_enter_actions()
	else:
		trigger_exit_actions()


func trigger_actions_from_float_threshold(value: float, threshold:float) -> void:
	trigger_actions_from_boolean(value > threshold)

func trigger_actions_from_float_threshold_0_5(value: float) -> void:
	trigger_actions_from_float_threshold(value, 0.5)

func trigger_actions_from_float_threshold_0_1(value: float) -> void:
	trigger_actions_from_float_threshold(value, 0.1)

func trigger_actions_from_float_threshold_0_9(value: float) -> void:
	trigger_actions_from_float_threshold(value, 0.9)



func trigger_actions_from_integer_under_zero(value: int) -> void:
	trigger_actions_from_boolean(value < 0)

func trigger_actions_from_integer_over_zero(value: int) -> void:
	trigger_actions_from_boolean(value > 0)

func trigger_actions_from_integer_equal_zero(value: int) -> void:
	trigger_actions_from_boolean(value == 0)

func trigger_actions_from_integer_not_equal_zero(value: int) -> void:
	trigger_actions_from_boolean(value != 0)



#endregion
