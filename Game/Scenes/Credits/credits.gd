class_name CreditsScreen extends Node

@onready var _credits_text_label: ClickableRichTextLabel = $CreditsText

func _ready() -> void:
  _credits_text_label.text = Text.credits

func _on_back_button_pressed() -> void:
  EventBus.Screen.load_main_menu.emit()
