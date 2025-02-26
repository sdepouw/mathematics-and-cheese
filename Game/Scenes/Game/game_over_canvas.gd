class_name GameOverCanvas
extends CanvasLayer

signal play_again_requested

@onready var _restart_button: EnhancedButton = $RestartButton
@onready var _main_menu_button: EnhancedButton = $MainMenuButton
@onready var _game_end_wait_timer: Timer = $GameEndWaitTimer

## Prevents players from playing down to the wire and accidentally skipping the
## Game Over screen
func _disable_game_end_buttons_momentarily() -> void:
  _restart_button.disabled = true
  _main_menu_button.disabled = true
  _game_end_wait_timer.start()
  await _game_end_wait_timer.timeout
  _restart_button.disabled = false
  _main_menu_button.disabled = false

func _on_restart_button_pressed() -> void:
  play_again_requested.emit()

func _on_main_menu_button_pressed() -> void:
  EventBus.load_main_menu.emit()


func _on_visibility_changed() -> void:
  if self.visible:
    _disable_game_end_buttons_momentarily()
