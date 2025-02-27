class_name OptionsScreen
extends Control

@onready var _clear_confirm_modal: ConfirmationModal = $ClearConfirmModal
@onready var _sound_amount: ProgressBar = $SoundAmount

# TODO: Add as button on main menu, and EventBus for loading this scene up.
# (Parallex = Yes)
# TODO: Wire up Confirm to delete the High Score file.
# Save options! Try saving as JSON instead of just the sound%


var _sound: float = 1.0

func _ready() -> void:
  _sound_amount.value = _sound

func _on_back_button_pressed() -> void:
  EventBus.load_main_menu.emit()

func _on_clear_data_button_pressed() -> void:
  var confirmed: bool = await _clear_confirm_modal.prompt()
  print(confirmed)

func _on_sound_amount_gui_input(event: InputEvent) -> void:
  if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
    var mouse_event: InputEventMouse = event as InputEventMouse
    var clicked_spot: float = clampf(mouse_event.position.x, 0, _sound_amount.size.x)
    _sound = clicked_spot / _sound_amount.size.x
    _sound_amount.value = _sound
