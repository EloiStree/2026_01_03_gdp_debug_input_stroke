class_name InputParsePrefixSuffixAroundString
extends Node

signal on_formated_text(text_formated:String)

@export var _prefix_to_append:String
@export var _suffix_to_append:String

func push_in_text(text:String):
	on_formated_text.emit(_prefix_to_append+text+_suffix_to_append)
	
