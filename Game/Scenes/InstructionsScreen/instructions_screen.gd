class_name InstructionsScreen extends Node

@onready var _instructions_label: ClickableRichTextLabel = $InstructionsLabel

func _ready() -> void:
  _instructions_label.text = Text.instructions\
    .format({"controls": Text.controls})\
    .strip_edges()

func _on_back_button_pressed() -> void:
  EventBus.Screen.load_main_menu.emit()
