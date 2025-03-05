## Button that contains a default size, uses the pointer cursor on hover, and
## plays a sound when clicked
class_name EnhancedButton extends Button

const _DEFAULT_SOUND: AudioStream = preload("res://Assets/Sounds/button_press.wav")

@export var sound_on_press: AudioStream = _DEFAULT_SOUND
@export var volume_db: float = -.5

@onready var _pressed_sound: SoundEffect = SoundEffect.new()

func _ready() -> void:
  _pressed_sound.stream = sound_on_press
  _pressed_sound.volume_db = volume_db
  self.add_child(_pressed_sound)
  self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
  self.pressed.connect(_on_pressed_play_sound)

func _on_pressed_play_sound() -> void:
  _pressed_sound.play()
  # Doesn't work, since other methods getting emitted to can't await this method
  #await _pressed_sound.finished
