class_name Equation extends Area2D

signal equation_clicked(equation: Equation)
signal equation_mouse_entered(equation: Equation)

enum MathOperation { ADD, SUBTRACT, MULTIPLY }

@onready var _equation_label: Label = $EquationLabel

var _answer: int
var _equation: String:
  set(value):
    _equation = value
    _equation_label.text = value

## Returns the current Answer for this Equation
func get_answer() -> int:
  return _answer

## Returns the current Equation
func get_equation() -> String:
  return _equation

func generate_new_equation() -> void:
  var operation: MathOperation = MathOperation.values().pick_random()
  var operand_1: int = randi_range(0, 9)
  var operand_2: int = randi_range(0, 9)
  _equation = _build_equation(operand_1, operand_2, operation)
  _answer = _calculate(operand_1, operand_2, operation)

func _ready() -> void:
  generate_new_equation()

func _build_equation(operand_1: int, operand_2: int, operation: MathOperation) -> String:
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

var _default_cursor_shape: Input.CursorShape
func _on_mouse_entered() -> void:
  _default_cursor_shape = Input.get_current_cursor_shape()
  equation_mouse_entered.emit(self)
  Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited() -> void:
  Input.set_default_cursor_shape(_default_cursor_shape)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
  var mouse_event: InputEventMouseButton = event as InputEventMouseButton
  if mouse_event and mouse_event.button_mask == MOUSE_BUTTON_MASK_LEFT and not mouse_event.double_click:
    equation_clicked.emit(self)
