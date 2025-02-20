class_name HUD
extends CanvasLayer

@onready var ScoreLabel: Label = $ScoreLabel;
@onready var HighScoreLabel: Label = $HighScoreLabel;
@onready var TimeLabel: Label = $TimeLabel;

func update_score_display(score: int) -> void:
  ScoreLabel.text = _clamp_score_display(score)

func update_high_score_display(high_score: int) -> void:
  HighScoreLabel.text = _clamp_score_display(high_score)

func update_time_display(time_remaining: float) -> void:
  if (time_remaining <= 0):
    TimeLabel.text = "GAME!"
    return;
  var format: String = "%2d"
  if (time_remaining < 10):
    # formats as as "0.0"
    # the 3 indicates '3 total symbols', and the 1 indicates 'only 1 digit to the right of the .'
    format = "%3.1f"
  TimeLabel.text = format % time_remaining

func _clamp_score_display(score: int) -> String:
  return "%05d" % max(0, min(score, 99999))
