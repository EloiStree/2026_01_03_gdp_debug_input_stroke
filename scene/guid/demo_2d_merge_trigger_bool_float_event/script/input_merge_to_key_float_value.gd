class_name InputMergeToKeyFloatEvent
extends Node

enum CaseMode {
		UNTOUCHED,
		UPPERCASE,
		LOWERCASE
	}


signal on_key_float_event_submitted(key:String, value:float)


static var _instance:InputMergeToKeyFloatEvent = null

static var _callable :Array[Callable] = []

static func add_listener(callable:Callable) -> void:
	if _callable.find(callable) == -1:
		_callable.append(callable)

static func remove_listener(callable:Callable) -> void:
	if _callable.find(callable) != -1:
		_callable.erase(callable)

static func _push_to_static_listener(key:String, value:float) -> void:
	for callable in _callable:
		if callable.is_valid():
			callable.call(key, value)

static func get_instance() -> InputMergeToKeyFloatEvent:
	if _instance == null:
		_instance = InputMergeToKeyFloatEvent.new()
	return _instance

@export var _add_as_singleton_at_ready:bool = true
@export var _strip_check:bool = true
@export var _replace_space_to_underscore:bool = true
@export var _remote_space_group:bool = true
@export var _case_mode:CaseMode = CaseMode.UPPERCASE

@export_group("Debug")
@export var _last_pushed_key_name:String = ""
@export var _last_pushed_value:float = 0.0

func push_in(key:String, value:float) -> void:
	if _strip_check:
		key = key.strip_edges()
	if _case_mode == CaseMode.UPPERCASE:
		key = key.to_upper()
	elif _case_mode == CaseMode.LOWERCASE:
		key = key.to_lower()
	while _remote_space_group and key.find("  ") != -1:
		key = key.replace("  ", " ")
	if _replace_space_to_underscore:
		key = key.replace(" ", "_")
	_last_pushed_key_name = key

	_last_pushed_value = value
	on_key_float_event_submitted.emit(key, value)
	_push_to_static_listener(key, value)


func  _ready() -> void:
	if _add_as_singleton_at_ready:
		_instance = self
	_last_pushed_key_name = ""
	_last_pushed_value = 0.0
