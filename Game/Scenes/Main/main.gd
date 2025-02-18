extends Node

@onready var _target1: Target = $Target1
@onready var _target2: Target = $Target2
@onready var _target3: Target = $Target3
@onready var _target4: Target = $Target4
@onready var _target5: Target = $Target5
@onready var _target6: Target = $Target6
@onready var _reticle: Sprite2D = $Reticle
@onready var _currentlyHeldThing: Label = $CurrentlyHeldThing;

var _targets: Array[Target]

var _currentThing: int
var _currentTargetIndex: int = 0
var _maxTargetIndex: int = 0

func _ready() -> void:
  _targets = [_target1, _target2, _target3, _target4, _target5, _target6]
  _reticle.position = _target1.position
  _maxTargetIndex = _targets.size() - 1
  _assignNewThing()

func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("fire"):
    if _currentThing == _targets[_currentTargetIndex].Id:
      print("hit!")
    else:
      print("miss!")
    _assignNewThing()
  if Input.is_action_just_pressed("move_right"):
    _newTarget(_currentTargetIndex + 1)
  elif Input.is_action_just_pressed("move_left"):
    _newTarget(_currentTargetIndex - 1)

func _assignNewThing() -> void:
  _currentThing = randi_range(1, 6)
  _currentlyHeldThing.text = str(_currentThing)

func _newTarget(newTarget: int) -> void:
  if newTarget < 0:
    newTarget = _maxTargetIndex
  if newTarget > _maxTargetIndex:
    newTarget = 0
  _currentTargetIndex = newTarget
  _reticle.position = _targets[_currentTargetIndex].position
