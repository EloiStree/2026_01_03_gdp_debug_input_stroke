class_name InputResourceMouseAreaDirectionFromCornerRectangle
extends Resource

## From what border of the screen position is calculated
## Direction from which the area is calculated
@export var _direction_from_corner: DirectionFromCorner = DirectionFromCorner.LEFT_RIGHT_DOWN_TOP


## Percent of the vertical distance in percent of the choosed corner
@export var _vertical_percent_from_corner: float = 0.25
## Percent of the horizontal distance in percent of the choosed corner
@export var _horizontal_percent_from_corner: float = 0.25
@export var _width_in_percent: float = 0.5
@export var _height_in_percent: float = 0.5

## Triggers name when entering the area
@export var _enter_text_trigger:Array[String] = ["SCREEN_RECT_LRDT_ENTER"]
## Triggers name when exiting the area
@export var _exit_text_trigger:Array[String] = ["SCREEN_RECT_LRDT_EXIT"]
## Triggers as boolean in/out of the area
@export var _enter_exit_trigger_boolean_name:Array[String] = ["SCREEN_RECT_LRDT"]

enum DirectionFromCorner {
    LEFT_RIGHT_DOWN_TOP,
    LEFT_RIGHT_TOP_DOWN,
    RIGHT_LEFT_TOP_DOWN,
    RIGHT_LEFT_DOWN_TOP,
}



func is_mouse_in_area_from_pixels_lrtd(mouse_position_lrtd: Vector2, screen_size: Vector2) -> bool:
    return is_mouse_in_area_from_percent_lrdt(Vector2(mouse_position_lrtd.x / screen_size.x, 1.0 - (mouse_position_lrtd.y / screen_size.y)))


func is_mouse_in_area_from_pixels_lrdt(mouse_position_lrdt: Vector2, screen_size: Vector2) -> bool:
    return is_mouse_in_area_from_percent_lrdt(Vector2(mouse_position_lrdt.x / screen_size.x, mouse_position_lrdt.y / screen_size.y))

func is_mouse_in_area_from_percent_lrdt(mouse_position_lrdt_percent: Vector2) -> bool:
    match _direction_from_corner:
        DirectionFromCorner.LEFT_RIGHT_DOWN_TOP:
            return (
                mouse_position_lrdt_percent.x >= _horizontal_percent_from_corner
                and mouse_position_lrdt_percent.x <= (_horizontal_percent_from_corner + _width_in_percent)
                and mouse_position_lrdt_percent.y >= _vertical_percent_from_corner
                and mouse_position_lrdt_percent.y <= (_vertical_percent_from_corner + _height_in_percent)
            )
        DirectionFromCorner.LEFT_RIGHT_TOP_DOWN:
            return (
                mouse_position_lrdt_percent.x >= _horizontal_percent_from_corner
                and mouse_position_lrdt_percent.x <= (_horizontal_percent_from_corner + _width_in_percent)
                and mouse_position_lrdt_percent.y <= (1.0 - _vertical_percent_from_corner)
                and mouse_position_lrdt_percent.y >= (1.0 - (_vertical_percent_from_corner + _height_in_percent))
            )
        DirectionFromCorner.RIGHT_LEFT_TOP_DOWN:
            return (
                mouse_position_lrdt_percent.x <= (1.0 - _horizontal_percent_from_corner)
                and mouse_position_lrdt_percent.x >= (1.0 - (_horizontal_percent_from_corner + _width_in_percent))
                and mouse_position_lrdt_percent.y <= (1.0 - _vertical_percent_from_corner)
                and mouse_position_lrdt_percent.y >= (1.0 - (_vertical_percent_from_corner + _height_in_percent))
            )
        DirectionFromCorner.RIGHT_LEFT_DOWN_TOP:
            return (
                mouse_position_lrdt_percent.x <= (1.0 - _horizontal_percent_from_corner)
                and mouse_position_lrdt_percent.x >= (1.0 - (_horizontal_percent_from_corner + _width_in_percent))
                and mouse_position_lrdt_percent.y >= _vertical_percent_from_corner
                and mouse_position_lrdt_percent.y <= (_vertical_percent_from_corner + _height_in_percent)
            )
        _:
            return false