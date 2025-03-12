class_name ScoreKeeper

signal score_updated(new_score: int, new_streak: int, is_on_hot_streak: bool, new_cheeses: int)

const _BASE_REWARD: int = 100
const _BASE_PENALTY: int = 50
const _HOT_STREAK_THRESHOLD: int = 2
const _CHEESE_REWARD_MULTIPLE: int = 5
const _QUICK_MATHS_TIME: float = 1.0

var _timer: NativeTimer = NativeTimer.new(_QUICK_MATHS_TIME)

var _current_score: int:
  set(value):
    _current_score = max(value, 0)
var _current_streak: int
var _best_streak: int
var _cheeses: int
var _just_rewarded_cheeses: int

func get_score() -> int:
  return _current_score

func get_streak() -> int:
  return _current_streak

func get_best_streak() -> int:
  return _best_streak

func get_cheeses() -> int:
  return _cheeses

func is_on_hot_streak() -> bool:
  return _current_streak > _HOT_STREAK_THRESHOLD

func just_rewarded_cheese() -> bool:
  return _just_rewarded_cheeses > 0

func score_hit() -> void:
  _current_streak += 1
  _just_rewarded_cheeses = 0
  if is_on_hot_streak():
    var streak_bonus: int = ceili(_BASE_REWARD * _current_streak * 0.15)
    _current_score += _BASE_REWARD + streak_bonus
  else:
    _current_score += _BASE_REWARD
  if _current_streak > _best_streak:
    _best_streak = _current_streak
  var cheese_streak: bool = _current_streak > 0 && _current_streak % _CHEESE_REWARD_MULTIPLE == 0
  var quick_maths: bool = _timer.within_wait_time()
  if cheese_streak:
    _cheeses += 1
    _just_rewarded_cheeses += 1
  if quick_maths:
    _cheeses += 1
    _just_rewarded_cheeses += 1
  _notify_score_updated()

func score_miss() -> void:
  _just_rewarded_cheeses = 0
  _current_score -= _BASE_PENALTY
  _current_streak = 0
  _notify_score_updated()

func reset() -> void:
  _current_score = 0
  _current_streak = 0
  _best_streak = 0
  _cheeses = 0
  _timer.restart()

func _notify_score_updated() -> void:
  score_updated.emit(_current_score, _current_streak, is_on_hot_streak(), _just_rewarded_cheeses)
