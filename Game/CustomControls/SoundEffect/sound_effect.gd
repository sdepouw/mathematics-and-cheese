## An AudioStreamPlayer whose volume is adjusted by a global Sound Effect Volume
## option.
class_name SoundEffect extends AudioStreamPlayer

func _ready() -> void:
  self.volume_linear *= clampf(Options.get_current_options().sound_volume, 0.0, 1.0)
  Options.options_updated.connect(_on_options_updated)

func _on_options_updated(option_values: Options.OptionValues) -> void:
  self.volume_linear *= clampf(option_values.sound_volume, 0.0, 1.0)
