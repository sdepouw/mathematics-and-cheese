class_name MainMenu
extends Node

signal load_game
signal load_credits

func _on_play_button_pressed() -> void:
  load_game.emit()

func _on_credits_button_pressed() -> void:
  load_credits.emit()
