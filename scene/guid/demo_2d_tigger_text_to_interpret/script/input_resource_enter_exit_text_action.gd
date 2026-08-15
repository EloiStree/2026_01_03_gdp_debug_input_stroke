class_name InputResourceEnterExitTextAction
extends Resource


@export var _action_on_enter: Array[String] = []
@export var _action_on_exit: Array[String] = []	


func has_action_on_enter() -> bool:
	return _action_on_enter.size() > 0

func has_action_on_exit() -> bool:
	return _action_on_exit.size() > 0

func set_actions_on_enter(action: Array[String]) -> void:
	_action_on_enter = action

func set_actions_on_exit(action: Array[String]) -> void:
	_action_on_exit = action


func set_action_on_enter(action: String) -> void:
	_action_on_enter = [action]

func set_action_on_exit(action: String) -> void:
	_action_on_exit = [action]




func append_action_on_enter(action: String) -> void:
	_action_on_enter.append(action)

func append_action_on_exit(action: String) -> void:
	_action_on_exit.append(action)



func append_actions_on_enter(actions: Array[String]) -> void:
	for action in actions:
		_action_on_enter.append(action)


func append_actions_on_exit(actions: Array[String]) -> void:
	for action in actions:
		_action_on_exit.append(action)



func get_actions_on_enter() -> Array[String]:
	return _action_on_enter

func get_actions_on_exit() -> Array[String]:
	return _action_on_exit




func remove_all_actions() -> void :
	_action_on_enter.clear()
	_action_on_exit.clear()
	
func remove_action_on_enter(action: String) -> void:
	_action_on_enter.erase(action)

func remove_action_on_exit(action: String) -> void:
	_action_on_exit.erase(action)
