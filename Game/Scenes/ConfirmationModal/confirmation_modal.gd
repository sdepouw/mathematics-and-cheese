## Prompts the player to Confirm or Cancel
class_name ConfirmationModal
extends Control

# Script and scene based off https://www.youtube.com/watch?v=GCFosi_53ro
signal confirmed(is_confirmed: bool)

@onready var _header_label: Label = %Header
@onready var _message_label: Label = %Message
@onready var _confirm_button: Button = %Confirm
@onready var _cancel_button: Button = %Cancel

func configure(header: String, message: String, confirm: String = "Yes", cancel: String = "No") -> ConfirmationModal:
  _header_label.text = header
  _message_label.text = message
  _confirm_button.text = confirm
  _cancel_button.text = cancel
  return self

func prompt() -> bool:
  return await confirmed

func _on_confirm_pressed() -> void:
  confirmed.emit(true)

func _on_cancel_pressed() -> void:
  confirmed.emit(false)
