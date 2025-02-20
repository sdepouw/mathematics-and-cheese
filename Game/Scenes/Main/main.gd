extends Node

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

var _targets: Array
var _currentTarget: Vector2
var _currentThing: int
var _currentScore: int
var _highScore: int = 0
var _gameOn: bool

## Gets the Target that the reticle is currently selecting
func _getCurrentTarget() -> Target:
  return _targets[_currentTarget.y][_currentTarget.x]

func _ready() -> void:
  _targets.append([_target1, _target2, _target3])
  _targets.append([_target4, _target5, _target6])
  _new_game()

func _new_game() -> void:
  _gameOn = true
  _currentScore = 0
  _currentTarget = Vector2.ZERO
  _reticle.show()
  _reticle.position = _getCurrentTarget().position
  _assignNewThing()
  _gameTimer.start()

func _process(_delta: float) -> void:
  if (!_gameOn):
    return;
  _hud.update_time_display(_gameTimer.time_left)
  _tryFire()
  _tryMoveReticle()

func _assignNewThing() -> void:
  # TODO: Show equations instead of flat numbers, randomize the numbers
  # TODO: Mouse avatar? Work cheese in somehow?
  var firstSet: Array = _targets[0]
  _currentThing = randi_range(1, _targets.size() * firstSet.size())
  _currentlyHeldThing.text = str(_currentThing)

func _tryFire() -> void:
  if Input.is_action_just_pressed("fire"):
    if _currentThing == _getCurrentTarget().Id:
      _currentScore += 50 # TODO: Consecutive bonus / combos
      _hud.update_score_display(_currentScore)
    else:
      _currentScore -= 5
      _hud.update_score_display(_currentScore)
    _assignNewThing()

func _tryMoveReticle() -> void:
  if !Input.is_anything_pressed():
    return
  var firstSet: Array = _targets[0]
  var maxX: int = firstSet.size() - 1
  var maxY: int = _targets.size() - 1
  var newX: float = _currentTarget.x;
  var newY: float = _currentTarget.y;
  if Input.is_action_just_pressed("move_right"):
    if _currentTarget.x == maxX:
      newX = 0
      newY = 1 if _currentTarget.y == 0 else 0
    else:
      newX = _currentTarget.x + 1
  if Input.is_action_just_pressed("move_left"):
    if _currentTarget.x == 0:
      newX = maxX
      newY = 0 if _currentTarget.y == 1 else 1
    else:
      newX = _currentTarget.x - 1
  if Input.is_action_just_pressed("move_down"):
    if _currentTarget.y == maxY:
      newY = 0
    else:
      newY = _currentTarget.y + 1
  if Input.is_action_just_pressed("move_up"):
    if _currentTarget.y == 0:
      newY = maxY
    else:
      newY = _currentTarget.y - 1
  if newX != _currentTarget.x or newY != _currentTarget.y:
    _currentTarget = Vector2(newX, newY)
    _reticle.position = _getCurrentTarget().position

func _on_game_timer_timeout() -> void:
  # TODO: Show Game Over screen
  _reticle.hide()
  _gameOn = false
  _hud.update_time_display(0)
  if _currentScore > _highScore:
    _hud.update_high_score_display(_currentScore)
    _highScore = _currentScore
  # TODO: Give the player a button to play again
  # TODO: And to start, for that matter
  await get_tree().create_timer(5.0).timeout
  _new_game()
