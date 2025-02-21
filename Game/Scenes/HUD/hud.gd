class_name HUD
extends CanvasLayer

@onready var _scoreLabel: Label = $ScoreLabel;
@onready var _highScoreLabel: Label = $HighScoreLabel;
@onready var _timeLabel: Label = $TimeLabel;

func update_score_display(score: int) -> void:
  _scoreLabel.text = _clamp_score_display(score)

func update_high_score_display(high_score: int) -> void:
  _highScoreLabel.text = _clamp_score_display(high_score)

func update_time_display(time_remaining: float) -> void:
  var format: String = "%2d"
  if (time_remaining < 10):
    # Formats float as as "0.0"
    # The 3 indicates '3 total symbols'
    # The 1 indicates 'only 1 digit to the right of the .'
    format = "%3.1f"
  _timeLabel.text = format % time_remaining

func _clamp_score_display(score: int) -> String:
  return "%05d" % max(0, score)

func _on_game_ended() -> void:
  _timeLabel.text = "Game!"
