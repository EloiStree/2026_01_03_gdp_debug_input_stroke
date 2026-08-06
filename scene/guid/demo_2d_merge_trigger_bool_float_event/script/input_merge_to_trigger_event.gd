class_name InputMergeToTriggerEvent
extends Node

enum CaseMode {
		UNTOUCHED,
		UPPERCASE,
		LOWERCASE
	}


signal on_trigger_event_submitted(trigger_name:String)

static var _instance:InputMergeToTriggerEvent = null
static var _callable :Array[Callable] = []

static func add_listener(callable:Callable) -> void:
	if _callable.find(callable) == -1:
		_callable.append(callable)

static func remove_listener(callable:Callable) -> void:
	if _callable.find(callable) != -1:
		_callable.erase(callable)

static func _push_to_static_listener(trigger_name:String) -> void:
	for callable in _callable:
		if callable.is_valid():
			callable.call(trigger_name)


@export var _add_as_singleton_at_ready:bool = true
@export var _strip_check:bool = true
@export var _replace_space_to_underscore:bool = true
@export var _remote_space_group:bool = true
@export var _case_mode:CaseMode = CaseMode.UPPERCASE

@export_group("Debug")
@export var _last_pushed_trigger_name:String = ""


static func get_instance() -> InputMergeToTriggerEvent:
	if _instance==null:
		_instance = InputMergeToTriggerEvent.new()		
	return _instance

func push_in(trigger_name:String) -> void:
	if _strip_check:
		trigger_name = trigger_name.strip_edges()
	if _case_mode == CaseMode.UPPERCASE:
		trigger_name = trigger_name.to_upper()
	elif _case_mode == CaseMode.LOWERCASE:
		trigger_name = trigger_name.to_lower()
	while _remote_space_group and trigger_name.find("  ") != -1:
		trigger_name = trigger_name.replace("  ", " ")
	if _replace_space_to_underscore:
		trigger_name = trigger_name.replace(" ", "_")
	_last_pushed_trigger_name = trigger_name

	on_trigger_event_submitted.emit(trigger_name)
	_push_to_static_listener(trigger_name)



func  _ready() -> void:
	if _add_as_singleton_at_ready:
		_instance = self
	_last_pushed_trigger_name = ""
