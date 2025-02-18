extends Node

var _currentThing: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  _currentThing = randi_range(1, 6)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
  pass

func _assignNewThing() -> void:
  _currentThing = randi_range(1, 6)
  var currentlyHeldThing: Label = $CurrentlyHeldThing;
  currentlyHeldThing.text = str(_currentThing)
