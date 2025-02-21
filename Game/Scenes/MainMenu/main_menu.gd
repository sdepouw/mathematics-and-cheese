class_name MainMenu
extends Node

func _on_play_button_pressed() -> void:
  EventBus.load_game.emit()

func _on_credits_button_pressed() -> void:
  EventBus.load_credits.emit()
