extends Node

@onready var _target1: Target = $Target1
@onready var _target2: Target = $Target2
@onready var _target3: Target = $Target3
@onready var _target4: Target = $Target4
@onready var _target5: Target = $Target5
@onready var _target6: Target = $Target6
@onready var _reticle: Sprite2D = $Reticle
@onready var _currentlyHeldThing: Label = $CurrentlyHeldThing;

var _targets: Array
var _currentTarget: Vector2 = Vector2.ZERO
var _currentThing: int

func _getReticleTarget() -> Target:
  return _targets[_currentTarget.y][_currentTarget.x]

func _ready() -> void:
  _targets.append([_target1, _target2, _target3])
  _targets.append([_target4, _target5, _target6])
  _reticle.position = _getReticleTarget().position
  _assignNewThing()

func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("fire"):
    if _currentThing == _getReticleTarget().Id:
      print("hit!")
    else:
      print("miss!")
    _assignNewThing()
  _tryMoveReticle()

func _assignNewThing() -> void:
  _currentThing = randi_range(1, 6)
  _currentlyHeldThing.text = str(_currentThing)

func _tryMoveReticle() -> void:
  if !Input.is_anything_pressed():
    return
  const maxX: float = 2
  const maxY: float = 1
  var newX: float = -1;
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
    newX = _currentTarget.x
  if Input.is_action_just_pressed("move_up"):
    if _currentTarget.y == 0:
      newY = maxY
    else:
      newY = _currentTarget.y - 1
    newX = _currentTarget.x
  if newX >= 0 and newY >= 0:
    _currentTarget = Vector2(newX, newY)
  _reticle.position = _getReticleTarget().position
