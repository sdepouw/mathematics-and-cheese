class_name OptionsScreen extends Control

@onready var _clear_confirm_modal: ConfirmationModal = $ClearConfirmModal
@onready var _sound_volume_progress_bar: ProgressBar = $SoundAmount

var _options: Options.OptionValues:
  set(value):
    _options = value
    if _options != null:
      _sound_volume_progress_bar.ratio = _options.sound_volume

func _ready() -> void:
  _options = Options.get_current_options()

func _on_sound_amount_gui_input(event: InputEvent) -> void:
  if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
    var mouse_event: InputEventMouse = event as InputEventMouse
    var clicked_spot: float = clampf(mouse_event.position.x, 0, _sound_volume_progress_bar.size.x)
    _sound_volume_progress_bar.mouse_default_cursor_shape = Control.CURSOR_HSPLIT
    _sound_volume_progress_bar.ratio = clicked_spot / _sound_volume_progress_bar.size.x
    _options.sound_volume = _sound_volume_progress_bar.ratio
  else:
    _sound_volume_progress_bar.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_clear_data_button_pressed() -> void:
  var confirmed: bool = await _clear_confirm_modal.prompt()
  if confirmed:
    HighScore.clear_high_score()

func _on_save_button_pressed() -> void:
  Options.save_options(_options)
  EventBus.Screen.load_main_menu.emit()

func _on_back_button_pressed() -> void:
  EventBus.Screen.load_main_menu.emit()

func _on_restore_defaults_button_pressed() -> void:
  _options = Options.get_default_options()
