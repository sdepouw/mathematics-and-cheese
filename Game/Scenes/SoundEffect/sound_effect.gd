extends AudioStreamPlayer

# TODO: Expose via Options menu
const sound_volume: float = 1.0

func _ready() -> void:
  self.volume_linear *= sound_volume
