class_name InputBoolToArrayOfActions
extends Node


signal on_action_found( action_name:String)
signal on_action_found_as_array(action_names:Array[String])

@export var _true_to_action:Array[String] = []
@export var _false_to_action:Array[String] = []

func trigger_from_boolean(value:bool):
	if value:
		trigger_actions_for_true_value()
	else:
		trigger_actions_for_false_value()
	
func trigger_actions_for_true_value():
	trigger_actions_of_array(_true_to_action)

func trigger_actions_for_false_value():
	trigger_actions_of_array(_false_to_action)

func trigger_actions_of_array(action_names:Array[String]):
	on_action_found_as_array.emit(action_names)
	for action_name in action_names:
		on_action_found.emit(action_name)

func clear_dictionary():
	_true_to_action.clear()
	_false_to_action.clear()

func append_action_for_true_value(action:String):
	_true_to_action.append(action)

func append_action_for_false_value(action:String):
	_false_to_action.append(action)

func append_actions_for_true_value(actions:Array[String]):
	for action in actions:
		_true_to_action.append(action)

func append_actions_for_false_value(actions:Array[String]):
	for action in actions:
		_false_to_action.append(action)
