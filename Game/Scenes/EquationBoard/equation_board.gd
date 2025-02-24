extends Node

const EQUATION_SCENE: PackedScene = preload("res://Scenes/Equation/equation.tscn")

## Emitted when any Equation on the board is selected
signal equation_selected(equation: String, answer: int)

@onready var _equation_row_1: EquationRow = $EquationRow1
@onready var _equation_row_3: EquationRow = $EquationRow3

# TODO: Remove
func _ready() -> void:
  generate_unique_equations()

func generate_unique_equations() -> void:
  var equations: Array[Equation] = _instantiate_unique_equations()
  for equation: Equation in equations:
    equation.equation_selected.connect(_on_equation_selected)
  _equation_row_1.set_row(equations[0], equations[1], equations[2])
  _equation_row_3.set_row(equations[3], equations[4], equations[5])

func _on_equation_selected(equation: String, answer: int) -> void:
  equation_selected.emit(equation, answer)

## Instantiates Equations, guaranteeing them to all have unique answers
func _instantiate_unique_equations() -> Array[Equation]:
  var equations: Array[Equation] = []
  while equations.size() < 6:
    var equation: Equation = _instantiate_equation()
    var answer: int = equation.get_answer()
    while equations.filter(func (eq: Equation) -> bool: return eq.get_answer() == answer).size() > 0:
      equation.queue_free()
      equation = _instantiate_equation()
    equations.push_back(equation)
  return equations

func _instantiate_equation() -> Equation:
  var instance: Node = EQUATION_SCENE.instantiate()
  add_child(instance)
  return instance
