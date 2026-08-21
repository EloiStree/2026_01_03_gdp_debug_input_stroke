class_name InputTriggerTextActionFromTwoChar
extends Node


signal on_one_byte_found(byte_0_255: int)
signal on_one_byte_found_as_string(char_0_255: String)

signal on_two_byte_found(left_byte_0_255: int, right_byte_0_255: int)
signal on_two_byte_found_as_string(two_chars_0_255: String)

signal on_text_action_found(text: String)



@export var _array_to_actions_list_one_byte: Array[Array] = []
@export var _dictionary_to_actions_list_two_byte: Dictionary[String, Array] = {}

@export_multiline() var _append_from_inspector: String = """
A♦️cmd:log A 65 found
AA♦️cmd:log AA found
"""


const DIAMOND: String = "♦️"


func _ready() -> void:
	_ensure_one_byte_array()
	append_from_given_diamond_key_value_text(_append_from_inspector)


func append_from_given_diamond_key_value_text(text: String) -> void:
	var lines: PackedStringArray = text.split("\n")

	for line in lines:
		var current_line := line.strip_edges()

		if current_line.is_empty():
			continue

		var index_diamond: int = current_line.find(DIAMOND)

		# Diamond must exist and cannot be the first character.
		if index_diamond <= 0:
			continue

		var left_part: String = current_line.substr(
			0,
			index_diamond
		).strip_edges()

		var right_part: String = current_line.substr(
			index_diamond + DIAMOND.length()
		).strip_edges()

		if left_part.is_empty():
			continue

		if right_part.is_empty():
			continue

		# Only 1 or 2 character keys are accepted.
		if left_part.length() != 1 and left_part.length() != 2:
			continue

		append_action_to_key(left_part, right_part)
			
		


# ============================================================================
# TRIGGER
# ============================================================================

func trigger_action_link_with_string_exact(text: String) -> void:
	var value := text.strip_edges()

	match value.length():
		1:
			trigger_action_with_one_char_as_byte(value.unicode_at(0))

		2:
			trigger_action_with_two_char(
				value.unicode_at(0),
				value.unicode_at(1)
			)


func trigger_action_with_one_char_as_byte(byte: int) -> void:
	if not _is_valid_byte(byte):
		return

	_ensure_one_byte_array()

	for item in _array_to_actions_list_one_byte[byte]:
		_emit_action(item)

	on_one_byte_found.emit(byte)
	on_one_byte_found_as_string.emit(char(byte))


func trigger_action_with_two_char(
	left_byte: int,
	right_byte: int
) -> void:
	if not _is_valid_byte(left_byte) or not _is_valid_byte(right_byte):
		return

	var key := char(left_byte) + char(right_byte)

	if not _dictionary_to_actions_list_two_byte.has(key):
		return

	for item in _dictionary_to_actions_list_two_byte[key]:
		_emit_action(item)

	on_two_byte_found.emit(left_byte, right_byte)
	on_two_byte_found_as_string.emit(key)


# ============================================================================
# ACTION EMISSION
# ============================================================================

func _emit_action(item: Variant) -> void:
	if item == null:
		return

	var action := str(item)

	if action.is_empty():
		return

	on_text_action_found.emit(action)


# ============================================================================
# VALIDATION / INTERNAL
# ============================================================================

func _is_valid_byte(value: int) -> bool:
	return value >= 0 and value <= 255


func _ensure_one_byte_array() -> void:
	if _array_to_actions_list_one_byte == null:
		_array_to_actions_list_one_byte = []

	while _array_to_actions_list_one_byte.size() < 256:
		_array_to_actions_list_one_byte.append([])

	if _array_to_actions_list_one_byte.size() > 256:
		_array_to_actions_list_one_byte.resize(256)


func _get_key_bytes(key: String) -> Array[int]:
	var value := key.strip_edges()

	if value.length() != 1 and value.length() != 2:
		return []

	var result: Array[int] = []

	for i in value.length():
		var byte := value.unicode_at(i)

		if not _is_valid_byte(byte):
			return []

		result.append(byte)

	return result


# ============================================================================
# CLEAR ALL
# ============================================================================

func clear_one_char_dictionary() -> void:
	_array_to_actions_list_one_byte.clear()
	_ensure_one_byte_array()


func clear_two_char_dictionary() -> void:
	_dictionary_to_actions_list_two_byte.clear()


func clear_all() -> void:
	clear_one_char_dictionary()
	clear_two_char_dictionary()


# ============================================================================
# REMOVE KEY
# ============================================================================

func remove_from_key(key: String) -> void:
	var value := key.strip_edges()
	var bytes := _get_key_bytes(value)

	if bytes.is_empty():
		return

	if bytes.size() == 1:
		_ensure_one_byte_array()
		_array_to_actions_list_one_byte[bytes[0]].clear()

	elif bytes.size() == 2:
		if _dictionary_to_actions_list_two_byte.has(value):
			_dictionary_to_actions_list_two_byte.erase(value)


# ============================================================================
# SET ACTION
# ============================================================================

func set_action_to_key(key: String, action: String) -> void:
	var value := key.strip_edges()
	var action_value := action.strip_edges()

	var bytes := _get_key_bytes(value)

	if bytes.is_empty():
		return

	if action_value.is_empty():
		remove_from_key(value)
		return

	if bytes.size() == 1:
		_ensure_one_byte_array()

		_array_to_actions_list_one_byte[bytes[0]] = [action_value]

	elif bytes.size() == 2:
		_dictionary_to_actions_list_two_byte[value] = [action_value]


# ============================================================================
# APPEND ACTION
# ============================================================================

func append_action_to_key(key: String, action: String) -> void:
	var value := key.strip_edges()
	var action_value := action.strip_edges()

	var bytes := _get_key_bytes(value)

	if bytes.is_empty() or action_value.is_empty():
		return

	if bytes.size() == 1:
		_ensure_one_byte_array()

		if not _array_to_actions_list_one_byte[bytes[0]].has(action_value):
			_array_to_actions_list_one_byte[bytes[0]].append(action_value)

	elif bytes.size() == 2:
		if not _dictionary_to_actions_list_two_byte.has(value):
			_dictionary_to_actions_list_two_byte[value] = []

		if not _dictionary_to_actions_list_two_byte[value].has(action_value):
			_dictionary_to_actions_list_two_byte[value].append(action_value)


# ============================================================================
# CLEAR ACTIONS FROM KEY
# ============================================================================

func clear_actions_to_key(key: String) -> void:
	var value := key.strip_edges()
	var bytes := _get_key_bytes(value)

	if bytes.is_empty():
		return

	if bytes.size() == 1:
		_ensure_one_byte_array()
		_array_to_actions_list_one_byte[bytes[0]].clear()

	elif bytes.size() == 2:
		if _dictionary_to_actions_list_two_byte.has(value):
			_dictionary_to_actions_list_two_byte[value].clear()


# ============================================================================
# SET MULTIPLE ACTIONS
# ============================================================================

func set_actions_to_key(key: String, actions: Array[String]) -> void:
	var value := key.strip_edges()
	var bytes := _get_key_bytes(value)

	if bytes.is_empty():
		return

	var clean_actions: Array[String] = []

	for action in actions:
		var action_value := action.strip_edges()

		if action_value.is_empty():
			continue

		if not clean_actions.has(action_value):
			clean_actions.append(action_value)

	if bytes.size() == 1:
		_ensure_one_byte_array()
		_array_to_actions_list_one_byte[bytes[0]] = clean_actions

	elif bytes.size() == 2:
		if clean_actions.is_empty():
			_dictionary_to_actions_list_two_byte.erase(value)
		else:
			_dictionary_to_actions_list_two_byte[value] = clean_actions


# ============================================================================
# APPEND MULTIPLE ACTIONS
# ============================================================================

func append_actions_to_key(key: String, actions: Array[String]) -> void:
	for action in actions:
		append_action_to_key(key, action)
