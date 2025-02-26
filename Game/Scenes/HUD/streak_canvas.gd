class_name StreakCanvas
extends CanvasLayer

@onready var _streak_label: Label = $StreakLabel
@onready var _streak_text: Label = $StreakText
@onready var _streak_animation_player: AnimationPlayer = $StreakAnimationPlayer

func hide_streak() -> void:
  _streak_label.hide()
  _streak_text.hide()
  _streak_animation_player.play("RESET")

func show_streak(streak: int) -> void:
  _streak_animation_player.play("move")
  _streak_text.show()
  _streak_label.show()
  _streak_label.text = "%03d" % streak
