## An AudioStreamPlayer whose volume is adjusted by a global Sound Effect Volume
## option.
class_name SoundEffect extends AudioStreamPlayer

@onready var _original_volume_linear: float = self.volume_linear

func _ready() -> void:
  _apply_volume_modifier(Options.get_current_options())
  Options.options_updated.connect(_on_options_updated)

func _on_options_updated(option_values: Options.OptionValues) -> void:
  _apply_volume_modifier(option_values)

func _apply_volume_modifier(option_values: Options.OptionValues) -> void:
  self.volume_linear = _original_volume_linear * clampf(option_values.sound_volume, 0.0, 1.0)
