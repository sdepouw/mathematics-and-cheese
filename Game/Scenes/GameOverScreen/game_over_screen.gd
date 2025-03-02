class_name GameOverScreen
extends Control

## How many points to award per number in the Best Streak
@export var best_streak_bonus_unit: int = 100

@onready var _score_value: Label = %ScoreValue
@onready var _streak_score_value: Label = %StreakScoreValue
@onready var _streak_value: Label = %StreakValue
@onready var _total_value: Label = %TotalValue

@onready var _score_line: HBoxContainer = %ScoreHBox
@onready var _streak_line: HBoxContainer = %StreakHBox
@onready var _sum_line: Line2D = %SumLine
@onready var _total_line: HBoxContainer = %TotalHBox

@onready var _score_line_timer: Timer = $ScoreLineTimer
@onready var _tally_timer: Timer = $StreakTallyTimer

@onready var _game_over_canvas: GameOverCanvas = $GameOverCanvas

@onready var _tally_sound: SoundEffect = $TallySound
@onready var _high_score_reached_sound: SoundEffect = $HighScoreReachedSound

var _score: int
var _best_streak: int
var _streak_score: int
var _total_score: int

var _current_streak_score: int:
  set(value):
    _current_streak_score = value
    _streak_score_value.text = "%d" % value
var _current_total_score: int:
  set(value):
    _current_total_score = value
    _total_value.text = "%d" % value

func load_scene_data(data: Variant) -> void:
  # data is Array[int]
  _score = data[0]
  _best_streak = data[1]

func _ready() -> void:
  _streak_score = _best_streak * best_streak_bonus_unit
  _total_score = _score + _streak_score
  var high_score_reached: bool = _total_score > HighScore.get_current_high_score()
  _initialize_tally_display()
  await _tally_async()

  if high_score_reached:
    HighScore.save_new_high_score(_total_score)
    _high_score_reached_sound.play()
    # TODO: Make the high score highlight color common. HighScore class?
    _total_value.add_theme_color_override("font_color", Color.GREEN)
  _game_over_canvas.show_game_over(high_score_reached)

func _initialize_tally_display() -> void:
  _score_line.hide()
  _streak_line.hide()
  _sum_line.hide()
  _total_line.hide()
  _game_over_canvas.hide()
  _score_value.text = "%d" % _score
  _streak_value.text = "%03d" % _best_streak
  _streak_score_value.text = "0"
  _total_value.text = "0"

func _tally_async() -> void:
  await _restart_score_line_timer_async()
  _score_line.show()
  await _restart_score_line_timer_async()
  _streak_line.show()
  while _current_streak_score < _streak_score:
    var increment: int = _current_streak_score + best_streak_bonus_unit
    _tally_timer.start()
    await _tally_timer.timeout
    _tally_sound.play()
    _current_streak_score = clampi(increment, 0, _streak_score)
  await _restart_score_line_timer_async()
  _sum_line.show()
  _total_line.show()
  while _current_total_score < _total_score:
    var increment: int = _current_total_score + 5276
    _tally_timer.start()
    await _tally_timer.timeout
    _tally_sound.play()
    _current_total_score = clampi(increment, 0, _total_score)
  await _restart_score_line_timer_async()

func _restart_score_line_timer_async() -> void:
  _score_line_timer.start()
  await _score_line_timer.timeout
