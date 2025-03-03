class_name GameOverCanvas extends CanvasLayer

@onready var _game_over_label: Label = $GameOverLabel
@onready var _restart_button: EnhancedButton = $RestartButton
@onready var _main_menu_button: EnhancedButton = $MainMenuButton
@onready var _game_end_wait_timer: Timer = $GameEndWaitTimer
@onready var _bluey_animation: AnimationPlayer = $BlueyAnimation

var _game_over_label_default: String

func _ready() -> void:
  self.hide()
  _game_over_label_default = _game_over_label.text
  _bluey_animation.play("RESET")
  show_game_over(true)

func show_game_over(new_high_score: bool) -> void:
  for node: CanvasItem in get_tree().get_nodes_in_group("HighScore"):
    node.visible = new_high_score
  self.show()
  _disable_game_end_buttons_momentarily()
  if new_high_score:
    _game_over_label.add_theme_color_override("font_color", Color.GREEN)
    _game_over_label.text = "New High Score!\nCongratulations!"
    _bluey_animation.play("celebrate")
  else:
    _game_over_label.remove_theme_color_override("font_color")
    _game_over_label.text = _game_over_label_default

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
  EventBus.Screen.load_game.emit()

func _on_main_menu_button_pressed() -> void:
  EventBus.Screen.load_main_menu.emit()
