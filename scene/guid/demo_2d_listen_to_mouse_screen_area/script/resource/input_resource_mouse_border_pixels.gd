class_name InputResourceMouseAreaBorderPixels
extends Resource

## From what border of the screen position is calculated
@export var _start_border: BorderAreaPixels = BorderAreaPixels.LEFT
## Pixels from the border choosed
@export var _pixels_from_border: int = 10
## Triggers name when entering the area
@export var _enter_text_trigger:Array[String] = ["SCREEN_BORDER_PX_LEFT_ENTER"]
## Triggers name when exiting the area
@export var _exit_text_trigger:Array[String] = ["SCREEN_BORDER_PX_LEFT_EXIT"]
## Triggers as boolean in/out of the area
@export var _enter_exit_trigger_boolean_name:Array[String] = ["SCREEN_BORDER_PX_LEFT"]

enum BorderAreaPixels {
	LEFT,
	RIGHT,
	TOP,
	BOTTOM,
}

func is_mouse_in_area_from_pixels_lrdt(mouse_position_lrdt: Vector2, screen_size: Vector2) -> bool:
	var horizontal_limit = 0
	var vertical_limit = 0
	match _start_border:
		BorderAreaPixels.LEFT:
			horizontal_limit = _pixels_from_border
			return mouse_position_lrdt.x <= horizontal_limit
		BorderAreaPixels.RIGHT:
			horizontal_limit = screen_size.x - _pixels_from_border
			return mouse_position_lrdt.x >= horizontal_limit
		BorderAreaPixels.TOP:
			vertical_limit = screen_size.y - _pixels_from_border
			return mouse_position_lrdt.y >= vertical_limit
		BorderAreaPixels.BOTTOM:
			vertical_limit = _pixels_from_border
			return mouse_position_lrdt.y <= vertical_limit

	return false
