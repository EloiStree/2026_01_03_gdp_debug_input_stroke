class_name InputResourceMouseAreaBorderPercent
extends Resource



## From what border of the screen position is calculated
@export var _start_border: BorderAreaPercent = BorderAreaPercent.LEFT
## Percent of the screen from the border choosed
@export var _percent_of_border: float = 0.1
## Triggers name when entering the area
@export var _enter_text_trigger:Array[String] = ["SCREEN_BORDER_PC_LEFT_ENTER"]
## Triggers name when exiting the area
@export var _exit_text_trigger:Array[String] = ["SCREEN_BORDER_PC_LEFT_EXIT"]
## Triggers as boolean in/out of the area
@export var _enter_exit_trigger_boolean_name:Array[String] = ["SCREEN_BORDER_PC_LEFT"]

enum BorderAreaPercent {
    LEFT,
    RIGHT,
    TOP,
    BOTTOM,
}

func is_mouse_in_area_from_pixels(mouse_position_lrdt_pixels: Vector2, screen_size: Vector2) -> bool:
    return is_mouse_in_area_from_percents(Vector2(mouse_position_lrdt_pixels.x / screen_size.x, mouse_position_lrdt_pixels.y / screen_size.y))


func is_mouse_in_area_from_percents(mouse_position_lrdt_percent: Vector2) -> bool:
    var horizontal_limit = 0.0
    var vertical_limit = 0.0
    match _start_border:
        BorderAreaPercent.LEFT:
            horizontal_limit = _percent_of_border
            return mouse_position_lrdt_percent.x <= horizontal_limit
        BorderAreaPercent.RIGHT:
            horizontal_limit = 1.0 - _percent_of_border
            return mouse_position_lrdt_percent.x >= horizontal_limit
        BorderAreaPercent.TOP:
            vertical_limit = _percent_of_border
            return mouse_position_lrdt_percent.y <= vertical_limit
        BorderAreaPercent.BOTTOM:
            vertical_limit = 1.0 - _percent_of_border
            return mouse_position_lrdt_percent.y >= vertical_limit
    return false

