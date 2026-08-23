class_name InputPrimitiveToDebugLog
extends Node

func push_in_print(text:String):
	print(text)
	
func push_in_print_variable_with_default_format(value:Variant):
	push_in_print_variable_with_format(value,"%s")

func push_in_print_variable_with_format(value:Variant, format:String="%s"):
	print(format%[value])

	
