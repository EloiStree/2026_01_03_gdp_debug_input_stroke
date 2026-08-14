class_name InputObserveMouseAreaTriggers
extends InputAbstractListenToMouseAreaTriggers



@export var _mouse_triggers_emitters:Array[InputAbstractListenToMouseAreaTriggers] = []

func _ready() -> void:
	for emitter in _mouse_triggers_emitters:
		if emitter != null:
			emitter.on_area_triggered_enter.connect(_on_area_triggered_enter)
			emitter.on_area_triggered_exit.connect(_on_area_triggered_exit)
			emitter.on_area_triggered_inside_value.connect(_on_area_triggered_inside_value)

func _on_area_triggered_enter(trigger_name:String) -> void:
	on_area_triggered_enter.emit(trigger_name)
func _on_area_triggered_exit(trigger_name:String) -> void:
	on_area_triggered_exit.emit(trigger_name)
func _on_area_triggered_inside_value(trigger_name:String, inside_value:bool) -> void:
	on_area_triggered_inside_value.emit(trigger_name, inside_value)
