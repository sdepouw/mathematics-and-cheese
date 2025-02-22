class_name CreditsScreen
extends Node

func _on_back_button_pressed() -> void:
  EventBus.load_main_menu.emit()

func _ready() -> void:
  if OS.get_name() != "HTML5":
    var label: RichTextLabel = $CreditsText
    label.meta_clicked.connect(_on_RichTextLabel_meta_clicked)

func _on_RichTextLabel_meta_clicked(meta: String) -> void:
  OS.shell_open(meta)
