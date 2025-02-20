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

var _targets: Array
var _currentTarget: Vector2 = Vector2.ZERO
var _currentThing: int
var _currentScore: int = 0

## Gets the Target that the reticle is currently selecting
func _getCurrentTarget() -> Target:
  return _targets[_currentTarget.y][_currentTarget.x]

func _ready() -> void:
  _targets.append([_target1, _target2, _target3])
  _targets.append([_target4, _target5, _target6])
  _reticle.show()
  _reticle.position = _getCurrentTarget().position
  _assignNewThing()

func _process(_delta: float) -> void:
  _tryFire()
  _tryMoveReticle()

func _assignNewThing() -> void:
  # TODO: Replace int ("current thing") with cheese names (which should be in each Target)
  # Should be able to say "pick a random Target, then grab its cheese, and set to current item"
  # Then when firing, compare current cheese to target cheese
  var firstSet: Array = _targets[0]
  _currentThing = randi_range(1, _targets.size() * firstSet.size())
  _currentlyHeldThing.text = str(_currentThing)

func _tryFire() -> void:
  if Input.is_action_just_pressed("fire"):
    if _currentThing == _getCurrentTarget().Id:
      _currentScore += 17
      _hud.update_score_display(_currentScore)
    else:
      print("miss!")
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
