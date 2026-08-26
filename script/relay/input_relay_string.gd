class_name InputRelayString
extends Node

signal on_string_to_relay_received(value:String)

@export var _last_string_received:String

func push_in_string_to_relay(value:String):
	on_string_to_relay_received.emit(value)
	_last_string_received = value
	
