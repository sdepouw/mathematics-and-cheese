class_name Target

extends Marker2D

## The ID of the Target to match
@export_range (1, 999) var Id: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  var targetIdentifier: Label = $TargetIdentifier
  targetIdentifier.text = str(Id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
  pass
