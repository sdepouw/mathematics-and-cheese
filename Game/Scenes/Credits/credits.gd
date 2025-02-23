class_name CreditsScreen
extends Node

const _CREDITS_TEXT_FILE_PATH: String = "res://Assets/credits.txt"

@onready var _credits_text_label: ClickableRichTextLabel = $CreditsText

func _ready() -> void:
  _credits_text_label.text = FileAccess.get_file_as_string(_CREDITS_TEXT_FILE_PATH)

func _on_back_button_pressed() -> void:
  EventBus.load_main_menu.emit()
