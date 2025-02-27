class_name MainMenu
extends Node

@onready var _game_title_label: Label = $GameTitleLabel

func _ready() -> void:
  _game_title_label.text = ProjectSettings.get_setting("application/config/name")

func _on_play_button_pressed() -> void:
  EventBus.load_game.emit()

func _on_instructions_button_pressed() -> void:
  EventBus.load_instructions.emit()

func _on_options_button_pressed() -> void:
  EventBus.load_options.emit()

func _on_credits_button_pressed() -> void:
  EventBus.load_credits.emit()
