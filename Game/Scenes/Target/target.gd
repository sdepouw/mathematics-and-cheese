class_name Target
extends Marker2D

enum MathOperation { ADD, SUBTRACT, MULTIPLY }

@onready var _target_identifier: Label = $TargetIdentifier

var _answer: int

func get_answer() -> int:
  return _answer

## Generates a new equation and returns the answer
func generate_new_equation() -> int:
  var operation: MathOperation = MathOperation.values().pick_random()
  var operand_1: int = randi_range(0, 9)
  var operand_2: int = randi_range(0, 9)
  _target_identifier.text = _build_display_equation(operand_1, operand_2, operation)
  _answer = _calculate(operand_1, operand_2, operation)
  return get_answer()

func _build_display_equation(operand_1: int, operand_2: int, operation: MathOperation) -> String:
  var operation_string: String
  match operation:
    MathOperation.ADD:
      operation_string = "+"
    MathOperation.SUBTRACT:
      operation_string = "-"
    MathOperation.MULTIPLY:
      operation_string = "*"
    _:
      return ""
  return "%d %s %d" % [operand_1, operation_string, operand_2]

func _calculate(operand_1: int, operand_2: int, operation: MathOperation) -> int:
  match operation:
    MathOperation.ADD:
      return operand_1 + operand_2
    MathOperation.SUBTRACT:
      return operand_1 - operand_2
    MathOperation.MULTIPLY:
      return operand_1 * operand_2
    _:
      return 0
