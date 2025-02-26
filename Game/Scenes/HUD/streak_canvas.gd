class_name StreakCanvas
extends CanvasLayer

@onready var _streak_label: Label = $StreakLabel
@onready var _streak_text: Label = $StreakText
@onready var _streak_animation_player: AnimationPlayer = $StreakAnimationPlayer

func update_streak_display(streak: int, show_streak: bool) -> void:
  if show_streak:
    _streak_animation_player.play("move")
    _streak_text.show()
    _streak_label.show()
    _streak_label.text = "%03d" % streak
  else:
    _streak_label.hide()
    _streak_text.hide()
    _streak_animation_player.play("RESET")
