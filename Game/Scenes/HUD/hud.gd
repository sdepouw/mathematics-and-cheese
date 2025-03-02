class_name HUD
extends CanvasLayer

@onready var _score_label: Label = $ScoreLabel;
@onready var _streak_canvas: StreakCanvas = $StreakCanvas
@onready var _high_score_label: Label = $HighScoreLabel;
@onready var _time_label: Label = $TimeLabel;

func update_score_display(new_score: int, new_streak: int, on_hot_streak: bool) -> void:
  _update_score_display(new_score)
  _update_streak_display(new_streak, on_hot_streak)

func update_high_score_display(high_score: int) -> void:
  _high_score_label.text = _clamp_score_display(high_score)

func update_time_display(time_remaining: float) -> void:
  var format: String = "%2d"
  if (time_remaining < 9.90):
    # Formats float as as "0.0"
    # The 3 indicates '3 total symbols'
    # The 1 indicates 'only 1 digit to the right of the .'
    format = "%3.1f"
  _time_label.text = format % time_remaining

func show_game_end() -> void:
  _time_label.text = "Game!"

func _update_score_display(score: int) -> void:
  _score_label.text = _clamp_score_display(score)

func _update_streak_display(streak: int, streak_visible: bool) -> void:
  _streak_canvas.update_streak_display(streak, streak_visible)

func _clamp_score_display(score: int) -> String:
  return "%07d" % max(0, score)
