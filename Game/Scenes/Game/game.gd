class_name Game
extends Node

@onready var _events: GameEvents = $GameEvents
@onready var _target_1: Target = $Target1
@onready var _target_2: Target = $Target2
@onready var _target_3: Target = $Target3
@onready var _target_4: Target = $Target4
@onready var _target_5: Target = $Target5
@onready var _target_6: Target = $Target6
@onready var _reticle: AnimatedSprite2D = $Reticle
@onready var _target_to_hit_label: Label = $TargetToHitLabel;
@onready var _hud: HUD = $HUD
@onready var _game_timer: Timer = $GameTimer
@onready var _countdown_timer: Timer = $CountdownTimer
@onready var _countdown_label: Label = $CountdownLabel
@onready var _pause_screen: PauseScreen = $PauseScreen

var _max_x: int:
  get:
    var first_row: Array = _targets_grid[0]
    return first_row.size() - 1
var _max_y: int:
  get: return _targets_grid.size() - 1
var _targets_grid: Array
var _targets: Array[Target]
var _targeted_grid_spot: Vector2
var _answer_to_hit: int:
  set(value):
    _answer_to_hit = value
    _target_to_hit_label.text = str(value)
var _game_on: bool

# Scoring
var _current_score: int:
  set(value):
    _current_score = max(value, 0)
    _hud.update_score_display(_current_score)
var _current_streak: int:
  set(value):
    _current_streak = value
    _hud.update_streak_display(_current_streak, _on_notable_streak())
func _on_notable_streak() -> bool:
  return _current_streak > 2

## Gets the Target that the reticle is currently selecting
func _get_current_target() -> Target:
  return _targets_grid[_targeted_grid_spot.y][_targeted_grid_spot.x]

func _ready() -> void:
  _targets_grid.append([_target_1, _target_2, _target_3])
  _targets_grid.append([_target_4, _target_5, _target_6])
  _targets = [_target_1, _target_2, _target_3, _target_4, _target_5, _target_6]
  _events.game_started.emit()
  HighScore.updated.connect(_hud.update_high_score_display)
  _hud.update_high_score_display(HighScore.get_current_high_score())

func _process(_delta: float) -> void:
  if _game_on:
    _hud.update_time_display(_game_timer.time_left)
  if !_countdown_timer.is_stopped():
    _countdown_label.text = str(ceili(_countdown_timer.time_left))

func generate_new_targets() -> void:
  for target: Target in _targets:
    var current_answer: int = target.generate_new_equation()
    # Guarantee all answers are unique
    while _targets.filter(func (element: Target) -> bool: return element.get_answer() == current_answer).size() > 1:
      current_answer = target.generate_new_equation()
  var selected_target: Target = _targets.pick_random()
  _answer_to_hit = selected_target.get_answer()

func _toggle_game_piece_visibility(visible: bool) -> void:
  _game_on = visible
  for item: CanvasItem in get_tree().get_nodes_in_group("GamePieces"):
    item.visible = visible

func _toggle_game_over_visibility(visible: bool) -> void:
  for item: CanvasItem in get_tree().get_nodes_in_group("GameOverPieces"):
    item.visible = visible

func _on_game_started() -> void:
  _current_score = 0
  _current_streak = 0
  _targeted_grid_spot = Vector2.ZERO
  _hud.update_time_display(_game_timer.wait_time)
  _toggle_game_over_visibility(false)
  await _run_countdown_async()
  _toggle_game_piece_visibility(true)
  _reticle.position = _get_current_target().position
  generate_new_targets()
  _game_timer.start()
  _pause_screen.can_pause = true

func _on_game_ended() -> void:
  _pause_screen.can_pause = false
  _toggle_game_piece_visibility(false)
  _toggle_game_over_visibility(true)
  if _current_score > HighScore.get_current_high_score():
    HighScore.save_new_high_score(_current_score)

func _on_player_confirm() -> void:
  if !_game_on:
    return
  if _answer_to_hit == _get_current_target().get_answer():
    _current_streak += 1
    const BASE_SCORE: int = 100
    if _on_notable_streak():
      var streak_bonus: int = ceili(BASE_SCORE * _current_streak * 0.15)
      _current_score += BASE_SCORE + streak_bonus
    else:
      _current_score += 100
  else:
    _current_score -= 50
    _current_streak = 0
  generate_new_targets()

func _on_player_moved(direction: Globals.Direction) -> void:
  if !_game_on:
    return
  var new_position: Vector2 = _get_new_reticle_position(direction)
  _targeted_grid_spot = new_position
  _reticle.position = _get_current_target().position

func _get_new_reticle_position(direction: Globals.Direction) -> Vector2:
  var new_position: Vector2 = _targeted_grid_spot
  if direction == Globals.Direction.LEFT: new_position.x -= 1
  if direction == Globals.Direction.RIGHT: new_position.x += 1
  if direction == Globals.Direction.DOWN: new_position.y += 1
  if direction == Globals.Direction.UP: new_position.y -= 1
  if new_position.x > _max_x: new_position.x = 0
  if new_position.x < 0: new_position.x = _max_x;
  if new_position.y > _max_y: new_position.y = 0;
  if new_position.y < 0: new_position.y = _max_y;
  return new_position

func _on_game_timer_timeout() -> void:
  _events.game_ended.emit()

func _on_main_menu_button_pressed() -> void:
  EventBus.load_main_menu.emit()

func _run_countdown_async() -> void:
  _countdown_label.show()
  _countdown_timer.start()
  await _countdown_timer.timeout
  _countdown_label.hide()
