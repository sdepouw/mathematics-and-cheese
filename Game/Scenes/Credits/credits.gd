class_name CreditsScreen
extends CanvasLayer

signal credits_ended

func _on_back_button_pressed() -> void:
  credits_ended.emit()
