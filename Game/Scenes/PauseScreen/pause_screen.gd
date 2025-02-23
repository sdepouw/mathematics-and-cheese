class_name PauseScreen
extends CanvasLayer

var can_pause: bool = false

@onready var _root_tree: SceneTree = get_tree()

func _ready() -> void:
  self.visible = false

func _process(_delta: float) -> void:
  if !can_pause:
    return
  if Input.is_action_just_pressed("cancel"):
    _root_tree.paused = !_root_tree.paused
    self.visible = _root_tree.paused
