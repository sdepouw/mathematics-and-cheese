class_name ScoreKeeper

signal score_updated(new_score: int, new_streak: int, on_hot_streak: bool)

const _BASE_REWARD: int = 100
const _BASE_PENALTY: int = 50
const _HOT_STREAK_THRESHOLD: int = 2

var _current_score: int
var _current_streak: int
var _best_streak: int

func get_score() -> int:
  return _current_score

func get_streak() -> int:
  return _current_streak

func get_best_streak() -> int:
  return _best_streak;

func on_hot_streak() -> bool:
  return _current_streak > _HOT_STREAK_THRESHOLD

func score_hit() -> void:
  _current_streak += 1
  if on_hot_streak():
    var streak_bonus: int = ceili(_BASE_REWARD * _current_streak * 0.15)
    _current_score += _BASE_REWARD + streak_bonus
  else:
    _current_score += _BASE_REWARD
  if _current_streak > _best_streak:
    _best_streak = _current_streak
  _notify_score_updated()

func score_miss() -> void:
  _current_score -= _BASE_PENALTY
  _current_streak = 0
  _notify_score_updated()

func reset() -> void:
  _current_score = 0
  _current_streak = 0
  _best_streak = 0
  _notify_score_updated()

func _notify_score_updated() -> void:
  score_updated.emit(_current_score, _current_streak, on_hot_streak())
