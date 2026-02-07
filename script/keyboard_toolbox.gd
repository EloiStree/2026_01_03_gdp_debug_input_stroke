class_name KeyboardToolbox extends Resource

class IntegerIdToName extends Resource:
    @export var integer_value: int
    @export var name_value: String


class IntegerIdToNameList extends Resource:
    @export var list: Array[IntegerIdToName] = []
