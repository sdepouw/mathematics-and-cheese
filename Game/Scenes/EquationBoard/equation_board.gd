class_name EquationBoard extends Node2D

const EQUATION_SCENE: PackedScene = preload("res://Scenes/Equation/equation.tscn")

## Emitted when any Equation on the board is selected
signal board_equation_selected(equation: Equation)

@onready var _equation_row_1: EquationRow = $EquationRow1
@onready var _equation_row_3: EquationRow = $EquationRow3
@onready var _reticle: AnimatedSprite2D = $Reticle
@onready var _move_cursor_sound: SoundEffect = $MoveCursorSound

# TODO: Calculate these based on the rows used
const _MAX_X: int = 2
const _MAX_Y: int = 1

var _euqation_under_reticle: Equation = null
var _equations: Array[Equation] = []
var _reticle_grid_position: Vector2

var _move_cursor_sound_enabled: bool = false
func toggle_cursor_sound(enabled: bool) -> void:
  _move_cursor_sound_enabled = enabled

## Array[Array[Equation]], stored so that one can use a Vector2 to navigate
## the grid of the board._equations_grid[1,0] will get the 2nd row
## of the 1st column, etc.
var _equations_grid: Array

func _ready() -> void:
  EventBus.player_moved.connect(_on_player_moved)
  EventBus.player_confirm.connect(_on_player_confirm)
  _equations = [
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation(),
    _instantiate_equation()
  ]
  for equation: Equation in _equations:
    equation.equation_clicked.connect(_on_equation_clicked)
    equation.equation_mouse_entered.connect(_on_equation_mouse_entered)
  _equation_row_1.map_to_positions(_equations[0], _equations[1], _equations[2])
  _equation_row_3.map_to_positions(_equations[3], _equations[4], _equations[5])
  _equations_grid.push_back([_equations[0], _equations[3]])
  _equations_grid.push_back([_equations[1], _equations[4]])
  _equations_grid.push_back([_equations[2], _equations[5]])

func reset_reticle_position() -> void:
  _euqation_under_reticle = _equations[0]
  _reticle.position = Vector2.ZERO

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

func _on_player_moved(direction: Globals.Direction) -> void:
  var new_position: Vector2 = _reticle_grid_position
  if direction == Globals.Direction.LEFT: new_position.x -= 1
  if direction == Globals.Direction.RIGHT: new_position.x += 1
  if direction == Globals.Direction.DOWN: new_position.y += 1
  if direction == Globals.Direction.UP: new_position.y -= 1
  if new_position.x > _MAX_X: new_position.x = 0
  if new_position.x < 0: new_position.x = _MAX_X;
  if new_position.y > _MAX_Y: new_position.y = 0;
  if new_position.y < 0: new_position.y = _MAX_Y;
  _move_reticle(new_position, true)

func _refresh_equations() -> void:
  for equation: Equation in _equations:
    equation.generate_new_equation()

func _on_player_confirm() -> void:
  if not _euqation_under_reticle:
    return
  board_equation_selected.emit(_euqation_under_reticle)

func _on_equation_clicked(equation: Equation) -> void:
  board_equation_selected.emit(equation)
  _move_reticle_to_equation(equation, false)

func _on_equation_mouse_entered(equation: Equation) -> void:
  _move_reticle_to_equation(equation, true)

func _move_reticle_to_equation(equation: Equation, play_move_sound: bool) -> void:
  var first_column: Array = _equations_grid[0]
  var second_column: Array = _equations_grid[1]
  var third_column: Array = _equations_grid[2]
  var new_position: Vector2
  if first_column.has(equation):
    new_position = Vector2(0, first_column.find(equation))
  elif second_column.has(equation):
    new_position = Vector2(1, second_column.find(equation))
  elif third_column.has(equation):
    new_position = Vector2(2, third_column.find(equation))
  if new_position != null:
    _move_reticle(new_position, play_move_sound)

func _move_reticle(new_position: Vector2, play_move_sound: bool) -> void:
  if _reticle_grid_position == new_position:
    return
  _reticle_grid_position = new_position
  _euqation_under_reticle = _equations_grid[_reticle_grid_position.x][_reticle_grid_position.y]
  _reticle.global_position = _euqation_under_reticle.global_position
  if play_move_sound and _move_cursor_sound_enabled:
    _move_cursor_sound.play()

func _instantiate_equation() -> Equation:
  var instance: Node = EQUATION_SCENE.instantiate()
  add_child(instance)
  return instance
