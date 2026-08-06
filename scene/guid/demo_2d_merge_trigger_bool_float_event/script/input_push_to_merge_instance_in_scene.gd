class_name InputPushToMergeInstanceInScene
extends Node


const splitters:Array[String] = [":", ",", ";", "|", " "]
func parse_and_push_line_from_context(text:String):
	if InputMergeToTriggerEvent.get_instance():
		var key_value_pairs:PackedStringArray = []
		for splitter in splitters:
			if text.find(splitter) != -1:
				key_value_pairs = text.split(splitter)
				break
		if key_value_pairs.size() == 2:
			var key = key_value_pairs[0].strip_edges()
			var value_str = key_value_pairs[1].strip_edges()
			if value_str.is_valid_float():
				var value_float = value_str.to_float()
				push_key_float_value(key, value_float)
			elif value_str.is_valid_int():
				var value_int = value_str.to_int()
				push_key_float_value(key, float(value_int))
			elif value_str.to_lower() == "true" or value_str.to_lower() == "false":
				var value_bool = value_str.to_lower() == "true"
				push_key_bool_value(key, value_bool)
			else:
				push_trigger_event(key)
		elif key_value_pairs.size() == 1:
			var key = key_value_pairs[0].strip_edges()
			push_trigger_event(key)
	
	

func push_trigger_event(trigger_name:String):
	if InputMergeToTriggerEvent.get_instance():
		InputMergeToTriggerEvent.get_instance().push_in(trigger_name)

func push_key_bool_value(key:String, value:bool):
	if InputMergeToKeyBoolEvent.get_instance():
		InputMergeToKeyBoolEvent.get_instance().push_in(key, value)

func push_key_float_value(key:String, value:float):
	if InputMergeToKeyFloatEvent.get_instance():
		InputMergeToKeyFloatEvent.get_instance().push_in(key, value)


func push_key_float_value_as_over_threshold_as_bool(key:String, value:float, threshold:float = 0):
	var bool_value = value > threshold
	push_key_bool_value(key, bool_value)

func push_key_float_value_as_under_threshold_as_bool(key:String, value:float, threshold:float = 0):
	var bool_value = value < threshold
	push_key_bool_value(key, bool_value)

func push_key_float_value_as_equal_zero_as_bool(key:String, value:float):
	var bool_value = value == 0
	push_key_bool_value(key, bool_value)

func push_key_float_value_in_range_as_bool(key:String, value:float, min_value:float, max_value:float, use_outter:bool = false):
	if use_outter:
		var bool_value = value <= min_value or value >= max_value
		push_key_bool_value(key, bool_value)
	else:
		var bool_value = value >= min_value and value <= max_value
		push_key_bool_value(key, bool_value)
