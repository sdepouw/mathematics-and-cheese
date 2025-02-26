## An AudioStreamPlayer whose volume is adjusted by a global Sound Effect Volume
## option.
class_name SoundEffect
extends AudioStreamPlayer

# TODO: Expose via Options menu
const sound_volume: float = 1.0

func _ready() -> void:
  self.volume_linear *= clampf(sound_volume, 0.0, 1.0)
