class_name Game
extends Node

## Emitted when a new game starts
signal game_started()
## Emitted when a game ends
signal game_ended()

@onready var _equation_board: EquationBoard = $EquationBoard
@onready var _answer_to_hit_label: Label = $AnswerToHitLabel
@onready var _hud: HUD = $HUD
@onready var _game_timer: Timer = $GameTimer
@onready var _countdown_timer: Timer = $CountdownTimer
@onready var _countdown_label: Label = $CountdownLabel
@onready var _pause_screen: PauseScreen = $PauseScreen
@onready var _game_end_wait_timer: Timer = $GameEndWaitTimer
@onready var _main_menu_button: Button = $MainMenuButton
@onready var _restart_button: Button = $RestartButton
@onready var _move_cursour_sound: AudioStreamPlayer = $MoveCursorSound

var _answer_to_hit: int:
  set(value):
    _answer_to_hit = value
    _answer_to_hit_label.text = str(value)
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

func _ready() -> void:
  game_started.emit()
  _toggle_game_piece_visibility(false)
  _toggle_game_over_visibility(false)
  HighScore.updated.connect(_hud.update_high_score_display)
  _hud.update_high_score_display(HighScore.get_current_high_score())

func _process(_delta: float) -> void:
  if _game_on:
    _hud.update_time_display(_game_timer.time_left)
  if !_countdown_timer.is_stopped():
    _countdown_label.text = str(ceili(_countdown_timer.time_left))

func _generate_new_equations() -> void:
  var equations: Array[Equation] = _equation_board.generate_unique_equations()
  _answer_to_hit = _pick_random_equation(equations).get_answer()

func _pick_random_equation(equations: Array[Equation]) -> Equation:
  return equations.pick_random()

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
  _hud.update_time_display(_game_timer.wait_time)
  _toggle_game_over_visibility(false)
  _generate_new_equations()
  await _run_countdown_async()
  _toggle_game_piece_visibility(true)
  _game_timer.start()
  _pause_screen.can_pause = true

func _on_game_ended() -> void:
  _disable_game_end_buttons_momentarily()
  _pause_screen.can_pause = false
  _toggle_game_piece_visibility(false)
  _equation_board.hide()
  _toggle_game_over_visibility(true)
  if _current_score > HighScore.get_current_high_score():
    HighScore.save_new_high_score(_current_score)

## Prevents players from playing down to the wire and accidentally skipping the
## Game Over screen
func _disable_game_end_buttons_momentarily() -> void:
  _restart_button.disabled = true
  _main_menu_button.disabled = true
  _game_end_wait_timer.start()
  await _game_end_wait_timer.timeout
  _restart_button.disabled = false
  _main_menu_button.disabled = false

func _on_board_equation_selected(equation: Equation) -> void:
  if !_game_on or equation == null:
    return
  if _answer_to_hit == equation.get_answer():
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
  _generate_new_equations()

func _on_game_timer_timeout() -> void:
  game_ended.emit()

func _on_restart_button_pressed() -> void:
  game_started.emit()

func _on_main_menu_button_pressed() -> void:
  EventBus.load_main_menu.emit()

func _run_countdown_async() -> void:
  _equation_board.show() # Allow preview of first set of equations
  _equation_board.reset_reticle_position()
  _countdown_label.show()
  _countdown_timer.start()
  await _countdown_timer.timeout
  _countdown_label.hide()

func _on_pause_screen_paused() -> void:
  _toggle_game_piece_visibility(false)
  _equation_board.hide()

func _on_pause_screen_unpaused() -> void:
  _toggle_game_piece_visibility(true)
  _equation_board.show()
