class_name MainMenu
extends Node

@onready var _gameTitleLabel: Label = $GameTitleLabel

func _ready() -> void:
  _gameTitleLabel.text = ProjectSettings.get_setting("application/config/name")

func _on_play_button_pressed() -> void:
  EventBus.load_game.emit()

func _on_credits_button_pressed() -> void:
  EventBus.load_credits.emit()
