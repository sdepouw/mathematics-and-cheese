class_name HUD
extends CanvasLayer

@onready var _score_label: Label = $ScoreLabel;
@onready var _streak_label: Label = $StreakLabel;
@onready var _high_score_label: Label = $HighScoreLabel;
@onready var _time_label: Label = $TimeLabel;

@onready var _streak_text: Label = $StreakText

func update_score_display(score: int) -> void:
  _score_label.text = _clamp_score_display(score)

func update_streak_display(streak: int, show_streak: bool) -> void:
  _streak_text.visible = show_streak
  _streak_label.visible = show_streak
  _streak_label.text = "%03d" % streak

func update_high_score_display(high_score: int, highlight: bool = false) -> void:
  _high_score_label.text = _clamp_score_display(high_score)
  if highlight:
    _high_score_label.add_theme_color_override("font_color", Color.GREEN)
  else:
    _high_score_label.remove_theme_color_override("font_color")

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

func _clamp_score_display(score: int) -> String:
  return "%07d" % max(0, score)
