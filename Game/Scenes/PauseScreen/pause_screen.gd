class_name PauseScreen
extends CanvasLayer

signal paused
signal unpaused

var can_pause: bool = false

@onready var _root_tree: SceneTree = get_tree()
@onready var _controls_label: Label = $ControlsLabel
@onready var _pause_sound: SoundEffect = $PauseSound
@onready var quit_confirm_modal: ConfirmationModal = $QuitConfirmModal

func _ready() -> void:
  self.visible = false
  _controls_label.text = Globals.get_controls_text()

func _process(_delta: float) -> void:
  # We have to manually parse inputs instead of relying on EventBus
  # because EventBus signals don't process while paused
  if Input.is_action_just_pressed("cancel"):
    _toggle_paused()

func _toggle_paused() -> void:
  if !can_pause:
    return
  _root_tree.paused = !_root_tree.paused
  self.visible = _root_tree.paused
  if _root_tree.paused:
    _pause_sound.play()
    paused.emit()
  else:
    unpaused.emit()

func _on_quit_button_pressed() -> void:
  var confirmed: bool = await quit_confirm_modal.prompt()
  if confirmed:
    EventBus.load_main_menu.emit()
    # HACK: Loading the new scene waits, so we wait so game doesn't unpause
    await get_tree().create_timer(.2).timeout
    _toggle_paused()
