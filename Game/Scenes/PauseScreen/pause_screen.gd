class_name PauseScreen
extends CanvasLayer

signal paused
signal unpaused

var can_pause: bool = false

@onready var _root_tree: SceneTree = get_tree()

func _ready() -> void:
  self.visible = false

func _process(_delta: float) -> void:
  if !can_pause:
    return
  if Input.is_action_just_pressed("cancel"):
    _toggle_paused()

func _toggle_paused() -> void:
  _root_tree.paused = !_root_tree.paused
  self.visible = _root_tree.paused
  if _root_tree.paused:
    paused.emit()
  else:
    unpaused.emit()

func _on_quit_button_pressed() -> void:
  EventBus.load_main_menu.emit()
  _toggle_paused()
