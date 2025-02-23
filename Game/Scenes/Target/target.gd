class_name Target
extends Marker2D

@onready var _target_identifier: Label = $TargetIdentifier

var _answer: int

func get_answer() -> int:
  return _answer

## Generates a new equation and returns the answer
func generate_new_equation() -> int:
  var operation: MathOperation = MathOperation.values().pick_random()
  var operand1: int = randi_range(0, 9)
  var operand2: int = randi_range(2, 11)
  _target_identifier.text = _build_display_equation(operand1, operand2, operation)
  _answer = _calculate(operand1, operand2, operation)
  return get_answer()

enum MathOperation { ADD, SUBTRACT, MULTIPLY }

func _build_display_equation(operand1: int, operand2: int, operation: MathOperation) -> String:
  var operationString: String
  match operation:
    MathOperation.ADD:
      operationString = "+"
    MathOperation.SUBTRACT:
      operationString = "-"
    MathOperation.MULTIPLY:
      operationString = "*"
    _:
      return ""
  return "%d %s %d" % [operand1, operationString, operand2]

func _calculate(operand1: int, operand2: int, operation: MathOperation) -> int:
  match operation:
    MathOperation.ADD:
      return operand1 + operand2
    MathOperation.SUBTRACT:
      return operand1 - operand2
    MathOperation.MULTIPLY:
      return operand1 * operand2
    _:
      return 0
