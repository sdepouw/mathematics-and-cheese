## Prompts the player to Confirm or Cancel
class_name ConfirmationModal
extends Control

# Script and scene based off https://www.youtube.com/watch?v=GCFosi_53ro
signal confirmed(is_confirmed: bool)

@onready var _background: ColorRect = $Background
@onready var _header_label: Label = %Header
@onready var _message_label: Label = %Message
@onready var _confirm_button: Button = %Confirm
@onready var _cancel_button: Button = %Cancel

@export var header: String = "Are you sure?"
@export var message: String = "Message body here"
@export var confirm: String = "Yes"
@export var cancel: String = "No"
@export var show_background: bool = true

func _ready() -> void:
  _header_label.text = header
  _message_label.text = message
  _confirm_button.text = confirm
  _cancel_button.text = cancel
  _background.visible = show_background
  hide()

func prompt() -> bool:
  show()
  var is_confirmed: bool = await confirmed
  hide()
  return is_confirmed

func _on_confirm_pressed() -> void:
  confirmed.emit(true)

func _on_cancel_pressed() -> void:
  confirmed.emit(false)
