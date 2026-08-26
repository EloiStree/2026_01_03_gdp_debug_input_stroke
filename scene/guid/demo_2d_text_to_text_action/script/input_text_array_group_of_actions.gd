class_name InputTextArrayGroupOfActions
extends Node

signal on_group_triggered_action(action:String)
signal on_group_triggered_actions(group_of_actions:Array[String])

@export var _group_of_actions:Array[String]=[]

func clear():
	_group_of_actions.clear()
	
func set_group_of_actions_by_copy(array:Array[String]):
	for action in array:
		_group_of_actions.append(action)

func set_group_of_actions_by_reference(array:Array[String]):
	_group_of_actions = array


func append_action(action:String):
	_group_of_actions.append(action)

func append_actions(array:Array[String]):
	for action in array:
		append_action(action)

func trigger_group_of_actions():
	on_group_triggered_actions.emit(_group_of_actions)
	for action in _group_of_actions:
		on_group_triggered_action.emit(action)

func append_text_as_line_action_array(text:String):
	var lines :PackedStringArray = text.split("\n")
	for line in lines:
		line = line.strip_edges()
		if line.begins_with("#"):
			continue
		append_action(line)
	
