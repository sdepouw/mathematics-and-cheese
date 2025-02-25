class_name InstructionsScreen
extends Node

const _INSTRUCTIONS_TEXT_FILE_PATH: String = "res://Assets/instructions.txt"
const _CONTROLS_TEXT_FILE_PATH: String = "res://Assets/controls.txt"
@onready var _instructions_label: ClickableRichTextLabel = $InstructionsLabel

func _ready() -> void:
  var instructions_template: String = FileAccess.get_file_as_string(_INSTRUCTIONS_TEXT_FILE_PATH)
  var controls: String = Globals.get_controls_text()
  _instructions_label.text = instructions_template.format({"controls": controls})

func _on_back_button_pressed() -> void:
  EventBus.load_main_menu.emit()
  EventBus.menu_button_pressed.emit()
