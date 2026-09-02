class_name InputUiOpenUrl
extends Node

@export var _url_to_open: String

func open_url(url: String) -> void:
	OS.shell_open(url)

func open_url_from_inspector() -> void:
	open_url(_url_to_open)
