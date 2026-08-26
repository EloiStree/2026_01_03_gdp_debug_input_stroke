class_name InputRelayInteger
extends Node

signal on_integer_to_relay_received(value:int)
signal on_integer_to_relay_received_as_string(value:String)

@export var _last_integer_received:int

func push_in_integer_to_relay(value:int):
	on_integer_to_relay_received.emit(value)
	_last_integer_received = value
	on_integer_to_relay_received_as_string.emit(str(value))
	
