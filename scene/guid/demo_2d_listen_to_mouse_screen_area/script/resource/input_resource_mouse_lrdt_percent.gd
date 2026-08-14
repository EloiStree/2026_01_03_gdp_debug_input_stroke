class_name InputResourceMouseAreaDirectionFromCorner
extends Resource

## From what border of the screen position is calculated
## Direction from which the area is calculated
@export var _direction_from_corner: DirectionFromCorner = DirectionFromCorner.LEFT_RIGHT_DOWN_TOP


## Percent of the vertical distance in percent of the choosed corner
@export var _vertical_percent_from_corner: float = 0.1
## Percent of the horizontal distance in percent of the choosed corner
@export var _horizontal_percent_from_corner: float = 0.1

## Triggers name when entering the area
@export var _enter_text_trigger:Array[String] = ["SCREEN_CORNER_LRDT_ENTER"]
## Triggers name when exiting the area
@export var _exit_text_trigger:Array[String] = ["SCREEN_CORNER_LRDT_EXIT"]
## Triggers as boolean in/out of the area
@export var _enter_exit_trigger_boolean_name:Array[String] = ["SCREEN_CORNER_LRDT"]

enum DirectionFromCorner {
	LEFT_RIGHT_DOWN_TOP,
	LEFT_RIGHT_TOP_DOWN,
	RIGHT_LEFT_TOP_DOWN,
	RIGHT_LEFT_DOWN_TOP,
}


func is_mouse_in_area_from_pixels_lrdt(mouse_position_lrdt: Vector2, screen_size: Vector2) -> bool:
	return is_mouse_in_area_from_percent_lrdt(Vector2(mouse_position_lrdt.x / screen_size.x, mouse_position_lrdt.y / screen_size.y))

func is_mouse_in_area_from_percent_lrdt(mouse_position_lrdt_percent: Vector2) -> bool:
	var horizontal_limit = 0.0
	var vertical_limit = 0.0
	match _direction_from_corner:
		DirectionFromCorner.LEFT_RIGHT_DOWN_TOP:
			horizontal_limit = _horizontal_percent_from_corner
			vertical_limit = _vertical_percent_from_corner
			return mouse_position_lrdt_percent.x <= horizontal_limit and mouse_position_lrdt_percent.y <= vertical_limit
		DirectionFromCorner.LEFT_RIGHT_TOP_DOWN:
			horizontal_limit = _horizontal_percent_from_corner
			vertical_limit = 1.0 - _vertical_percent_from_corner
			return mouse_position_lrdt_percent.x <= horizontal_limit and mouse_position_lrdt_percent.y >= vertical_limit
		DirectionFromCorner.RIGHT_LEFT_TOP_DOWN:
			horizontal_limit = 1.0 - _horizontal_percent_from_corner
			vertical_limit = 1.0 - _vertical_percent_from_corner
			return mouse_position_lrdt_percent.x >= horizontal_limit and mouse_position_lrdt_percent.y >= vertical_limit
		DirectionFromCorner.RIGHT_LEFT_DOWN_TOP:
			horizontal_limit = 1.0 - _horizontal_percent_from_corner
			vertical_limit = _vertical_percent_from_corner
			return mouse_position_lrdt_percent.x >= horizontal_limit and mouse_position_lrdt_percent.y <= vertical_limit

	return false
