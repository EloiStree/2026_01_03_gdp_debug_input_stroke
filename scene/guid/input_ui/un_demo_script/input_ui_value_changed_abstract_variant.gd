class_name  InputUiValueChangedAbstractVariant
extends Node

signal on_value_changed_with_previous_value_as_variant(new_value:Variant, previous_value:Variant)

func _notify_change_as_variant(new_value:Variant, previous_value:Variant) -> void:
	if new_value != previous_value:
		on_value_changed_with_previous_value_as_variant.emit(new_value, previous_value)
