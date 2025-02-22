class_name Game
extends Node

# TODO: Show 'Game Over' stuff besides just "Game!" along the top
# TODO: Finite State Machine instead of bool _gameOn?
# Game is new -> started <-> paused, started -> stopped, stopped -> new

# TODO: Each match also rewards a cheese? ('flip' equation card?)
# Could show equations instead of numbers, and then a cheese is (sometimes) revealed
# TODO: More complex scoring
# - Combos / Consecutive Bonuses
# - At end, each found cheese adds to score
# TODO: Sound/Animation when scoring
# TODO: Sound/Animation/Congrats on new high score

@onready var _events: GameEvents = $GameEvents
@onready var _target1: Target = $Target1
@onready var _target2: Target = $Target2
@onready var _target3: Target = $Target3
@onready var _target4: Target = $Target4
@onready var _target5: Target = $Target5
@onready var _target6: Target = $Target6
@onready var _reticle: Sprite2D = $Reticle
@onready var _currentlyHeldThing: Label = $CurrentlyHeldThing;
@onready var _hud: HUD = $HUD
@onready var _gameTimer: Timer = $GameTimer
@onready var _countdownTimer: Timer = $CountdownTimer
@onready var _countdownLabel: Label = $CountdownLabel

var _maxX: int
var _maxY: int
var _targets: Array
var _currentTarget: Vector2
var _currentThing: int
var _gameOn: bool

var _currentScore: int:
  set(value):
    _currentScore = max(value, 0)
    _hud.update_score_display(_currentScore)

## Gets the Target that the reticle is currently selecting
func _getCurrentTarget() -> Target:
  return _targets[_currentTarget.y][_currentTarget.x]

func _ready() -> void:
  _targets.append([_target1, _target2, _target3])
  _targets.append([_target4, _target5, _target6])
  var firstSet: Array = _targets[0]
  _maxX = firstSet.size() - 1
  _maxY = _targets.size() - 1
  _events.game_started.emit()
  HighScore.updated.connect(_hud.update_high_score_display)
  _hud.update_high_score_display(HighScore.get_current_high_score())

func _process(_delta: float) -> void:
  if _gameOn:
    _hud.update_time_display(_gameTimer.time_left)
  if !_countdownTimer.is_stopped():
    _countdownLabel.text = str(ceili(_countdownTimer.time_left))

func _assignNewThing() -> void:
  var firstSet: Array = _targets[0]
  _currentThing = randi_range(1, _targets.size() * firstSet.size())
  _currentlyHeldThing.text = str(_currentThing)

func _toggle_game_piece_visibility(gamePiecesVisible: bool) -> void:
  _gameOn = gamePiecesVisible
  for item: CanvasItem in get_tree().get_nodes_in_group("GamePieces"):
    item.visible = gamePiecesVisible

func _toggle_game_over_visibility(visible: bool) -> void:
  for item: CanvasItem in get_tree().get_nodes_in_group("GameOverPieces"):
    item.visible = visible

func _on_game_started() -> void:
  _currentScore = 0
  _currentTarget = Vector2.ZERO
  _hud.update_time_display(_gameTimer.wait_time)
  _toggle_game_over_visibility(false)
  await _run_countdown_async()
  _toggle_game_piece_visibility(true)
  _reticle.position = _getCurrentTarget().position
  _assignNewThing()
  _gameTimer.start()

func _on_game_ended() -> void:
  _toggle_game_piece_visibility(false)
  _toggle_game_over_visibility(true)
  if _currentScore > HighScore.get_current_high_score():
    HighScore.save_new_high_score(_currentScore)

func _on_player_fired() -> void:
  if !_gameOn:
    return
  if _currentThing == _getCurrentTarget().Id:
    _currentScore += 10
  else:
    _currentScore -= 5
  _assignNewThing()

func _on_player_moved(direction: Globals.Direction) -> void:
  if !_gameOn:
    return
  var newX: float = _currentTarget.x;
  var newY: float = _currentTarget.y;
  if direction == Globals.Direction.LEFT: newX -= 1
  if direction == Globals.Direction.RIGHT: newX += 1
  if direction == Globals.Direction.DOWN: newY += 1
  if direction == Globals.Direction.UP: newY -= 1
  if newX > _maxX: newX = 0
  if newX < 0: newX = _maxX;
  if newY > _maxY: newY = 0;
  if newY < 0: newY = _maxY;
  _currentTarget = Vector2(newX, newY)
  _reticle.position = _getCurrentTarget().position

func _on_game_timer_timeout() -> void:
  _events.game_ended.emit()

func _on_main_menu_button_pressed() -> void:
  EventBus.load_main_menu.emit()

func _run_countdown_async() -> void:
  _countdownLabel.show()
  _countdownTimer.start()
  await _countdownTimer.timeout
  _countdownLabel.hide()
