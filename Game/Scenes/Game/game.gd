## The Game
class_name Game
extends Node

# TODO: Show 'Game Over' stuff besides just "Game!" along the top
# TODO: Persist high score
# TODO: Remove timer to restart, and give player a 'Restart' button
# Also a button to take back to main menu once that exists
# TODO: Finite State Machine instead of bool _gameOn?
# Game is new -> started <-> paused, started -> stopped, stopped -> new

# TODO: Each match also rewards a cheese? ('flip' equation card?)
# Could show equations instead of numbers, and then a cheese is (sometimes) revealed
# TODO: More complex scoring
# - Combos / Consecutive Bonuses
# - At end, each found cheese adds to score

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

var _highScore: int = 0:
  set(value):
    _highScore = value
    _hud.update_high_score_display(value)

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

func _process(_delta: float) -> void:
  if _gameOn:
    _hud.update_time_display(_gameTimer.time_left)

func _on_game_started() -> void:
  _gameOn = true
  _currentScore = 0
  _currentTarget = Vector2.ZERO
  _reticle.show()
  _currentlyHeldThing.show()
  _reticle.position = _getCurrentTarget().position
  _assignNewThing()
  _gameTimer.start()

func _on_game_ended() -> void:
  _gameOn = false
  _reticle.hide()
  _currentlyHeldThing.hide()
  if _currentScore > _highScore:
    _highScore = _currentScore
  await get_tree().create_timer(5.0).timeout
  _events.game_started.emit()

func _assignNewThing() -> void:
  var firstSet: Array = _targets[0]
  _currentThing = randi_range(1, _targets.size() * firstSet.size())
  _currentlyHeldThing.text = str(_currentThing)

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
