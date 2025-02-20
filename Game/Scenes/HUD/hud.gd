class_name HUD
extends CanvasLayer

@onready var ScoreLabel: Label = $ScoreLabel;

func _ready() -> void:
  print(ScoreLabel.get_theme_font_size("base_theme"))

func update_score_display(score: int) -> void:
  ScoreLabel.text = "%05d" % score
