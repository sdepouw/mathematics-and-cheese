class_name GameOverScreen
extends Control

## How many points to award per number in the Best Streak
@export var best_streak_bonus_unit: int = 1000

@onready var _score_value: Label = %ScoreValue
@onready var _streak_score_value: Label = %StreakScoreValue
@onready var _streak_value: Label = %StreakValue
@onready var _total_value: Label = %TotalValue

@onready var _score_line: HBoxContainer = %ScoreHBox
@onready var _streak_line: HBoxContainer = %StreakHBox
@onready var _sum_line: Line2D = %SumLine
@onready var _total_line: HBoxContainer = %TotalHBox

var _score: int
var _streak_score: int
var _total_score: int
var _best_streak: int

var _current_streak_score: int:
  set(value):
    _current_streak_score = value
    _streak_score_value.text = "%d" % value
var _current_total_score: int:
  set(value):
    _current_total_score = value
    _total_value.text = "%d" % value

var _tallying: bool
var _waited_for_total: bool
var _done_tallying: bool

func load_scene_data(data: Variant) -> void:
  # data is Array[int]
  _score = data[0]
  _best_streak = data[1]

func _ready() -> void:
  # Debug
  _score = 100000
  _best_streak = 20

  _score_line.hide()
  _streak_line.hide()
  _sum_line.hide()
  _total_line.hide()
  _score_value.text = "%d" % _score
  _streak_value.text = "%03d" % _best_streak
  _streak_score_value.text = "0"
  _total_value.text = "0"
  _streak_score = _best_streak * best_streak_bonus_unit
  _total_score = _score + _streak_score
  await get_tree().create_timer(.5).timeout
  _score_line.show()
  await get_tree().create_timer(.5).timeout
  _tallying = true

func _process(_delta: float) -> void:
  if not _done_tallying:
    _try_tally()
  else:
    pass
    # Show high score congrats, or general 'game over' message
    # Show Play Again / Back to Menu buttons

func _try_tally() -> void:
  if not _tallying:
    return
  if _current_streak_score < _streak_score:
    if not _streak_line.visible:
      _streak_line.show()
    _current_streak_score = (clamp(_current_streak_score + round(best_streak_bonus_unit / 2), 0, _streak_score))
    return
  if not _waited_for_total:
    await get_tree().create_timer(.5).timeout
    _waited_for_total = true
  if _current_total_score < _total_score:
    if not _total_line.visible:
      _sum_line.show()
      _total_line.show()
    _current_total_score = clampi(_current_total_score + 1039, 0, _total_score)
  else:
    _tallying = false
    _done_tallying = true
