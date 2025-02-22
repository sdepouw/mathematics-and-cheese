class_name CreditsScreen
extends Node

@onready var _creditsRichTextLabel: RichTextLabel = $CreditsText

func _on_back_button_pressed() -> void:
  EventBus.load_main_menu.emit()

func _ready() -> void:
  if OS.get_name() != "HTML5":
    _creditsRichTextLabel.meta_clicked.connect(OS.shell_open)
