class_name EquationBoard
extends Node2D

const EQUATION_SCENE: PackedScene = preload("res://Scenes/Equation/equation.tscn")

## Emitted when any Equation on the board is selected
signal board_equation_selected(equation: Equation)

@onready var _equation_row_1: EquationRow = $EquationRow1
@onready var _equation_row_3: EquationRow = $EquationRow3
#@onready var _reticle: AnimatedSprite2D = $Reticle

# TODO: Calculate these based on the rows used
const _MAX_X: int = 2
const _MAX_Y: int = 1

var _selected_equation: Equation = null
var _equations: Array[Equation] = []

func _ready() -> void:
  EventBus.player_moved.connect(_on_player_moved)
  EventBus.player_confirm.connect(_on_equation_selected.bind(_selected_equation))
  _equations = [
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation()
  ]
  for equation: Equation in _equations:
    equation.equation_selected.connect(_on_equation_selected)
  _equation_row_1.map_to_positions(_equations[0], _equations[1], _equations[2])
  _equation_row_3.map_to_positions(_equations[3], _equations[4], _equations[5])

func _on_player_moved(direction: Globals.Direction) -> void:
  print("moved! ", direction)
  #var new_position: Vector2 = _get_new_reticle_position(direction)
  #_targeted_grid_spot = new_position
  #_reticle.position = _get_current_target().position

func _get_new_reticle_position(direction: Globals.Direction) -> Vector2:
  var new_position: Vector2 = Vector2.ZERO #_targeted_grid_spot
  if direction == Globals.Direction.LEFT: new_position.x -= 1
  if direction == Globals.Direction.RIGHT: new_position.x += 1
  if direction == Globals.Direction.DOWN: new_position.y += 1
  if direction == Globals.Direction.UP: new_position.y -= 1
  if new_position.x > _MAX_X: new_position.x = 0
  if new_position.x < 0: new_position.x = _MAX_X;
  if new_position.y > _MAX_Y: new_position.y = 0;
  if new_position.y < 0: new_position.y = _MAX_Y;
  return new_position

func generate_unique_equations() -> Array[Equation]:
  # Refresh all equations
  for equation: Equation in _equations:
    equation.generate_new_equation()
  # If any equation's answer is a duplicate, refresh again
  for equation: Equation in _equations:
    if(_equations.filter(func (eq: Equation) -> bool: return eq.get_answer() == equation.get_answer()).size() > 1):
      generate_unique_equations()
      break
  return _equations

func _refresh_equations() -> void:
  for equation: Equation in _equations:
    equation.generate_new_equation()

func _on_equation_selected(equation: Equation) -> void:
  if not equation:
    return
  board_equation_selected.emit(equation)

func _instantiate_equation() -> Equation:
  var instance: Node = EQUATION_SCENE.instantiate()
  add_child(instance)
  return instance
