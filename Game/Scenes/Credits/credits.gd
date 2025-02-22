class_name CreditsScreen
extends Node

func _on_back_button_pressed() -> void:
  EventBus.load_main_menu.emit()
