class_name InputRelayFloat
extends Node

signal on_float_to_relay_received(value:float)
signal on_float_to_relay_received_as_string(value:String)

@export var _last_float_received:float
@export var _debug_float_format="%s"

func push_in_float_to_relay(value:float):
	on_float_to_relay_received.emit(value)
	_last_float_received = value
	on_float_to_relay_received_as_string.emit(_debug_float_format%[value])
	
