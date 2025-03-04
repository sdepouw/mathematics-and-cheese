class_name ScoreKeeper

signal score_updated(new_score: int, new_streak: int, on_hot_streak: bool, new_cheese: bool)

const _BASE_REWARD: int = 100
const _BASE_PENALTY: int = 50
const _HOT_STREAK_THRESHOLD: int = 2
const _CHEESE_REWARD_MULTIPLE: int = 5

var _current_score: int:
  set(value):
    _current_score = max(value, 0)
var _current_streak: int
var _best_streak: int
var _cheeses: int

func get_score() -> int:
  return _current_score

func get_streak() -> int:
  return _current_streak

func get_best_streak() -> int:
  return _best_streak

func get_cheeses() -> int:
  return _cheeses

func on_hot_streak() -> bool:
  return _current_streak > _HOT_STREAK_THRESHOLD

func just_rewarded_cheese() -> bool:
  return _current_streak > 0 && _current_streak % _CHEESE_REWARD_MULTIPLE == 0

func score_hit() -> bool:
  _current_streak += 1
  if on_hot_streak():
    var streak_bonus: int = ceili(_BASE_REWARD * _current_streak * 0.15)
    _current_score += _BASE_REWARD + streak_bonus
  else:
    _current_score += _BASE_REWARD
  if _current_streak > _best_streak:
    _best_streak = _current_streak
  if just_rewarded_cheese():
    _cheeses += 1
  _notify_score_updated()
  return _current_streak == _HOT_STREAK_THRESHOLD + 1

func score_miss() -> void:
  _current_score -= _BASE_PENALTY
  _current_streak = 0
  _notify_score_updated()

func reset() -> void:
  _current_score = 0
  _current_streak = 0
  _best_streak = 0
  _cheeses = 0
  _notify_score_updated()

func _notify_score_updated() -> void:
  score_updated.emit(_current_score, _current_streak, on_hot_streak(), just_rewarded_cheese())
