## Button that contains a default size, uses the pointer cursor on hover, and
## plays a sound when clicked
class_name EnhancedButton
extends Button

@onready var _pressed_sound: AudioStreamPlayer = $PressedSound

func _on_pressed_play_sound() -> void:
  print("_on_pressed_play_sound")
  _pressed_sound.play()
  await _pressed_sound.finished # Doesn't work.
