class_name StreakCanvas
extends CanvasLayer

@onready var _streak_label: Label = $StreakLabel
@onready var _streak_text: Label = $StreakText
@onready var _streak_animation_player: AnimationPlayer = $StreakAnimationPlayer

func _ready() -> void:
  _hide()

func update_streak_display(streak: int, streak_visible: bool) -> void:
  if streak_visible:
    _show(streak)
  else:
    _hide()

func _show(streak: int) -> void:
  _streak_animation_player.play("move")
  _streak_text.show()
  _streak_label.show()
  _streak_label.text = "%03d" % streak

func _hide() -> void:
  _streak_label.hide()
  _streak_text.hide()
  _streak_animation_player.play("RESET")
