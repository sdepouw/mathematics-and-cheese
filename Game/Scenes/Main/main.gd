class_name Main
extends Node

# TODO: Update to monospaced font. Google has a 'pixel' font?
# TODO: 'Main Menu' with 'Start' and 'Credits' (attribute icon, font, license)
# TODO: Bluey credited to "Alblune" https://alblune.com/,
# from "Squakross: Home Squeak Home" https://www.squeakross.cool/

@onready var _gameScene: PackedScene = preload("res://Scenes/Game/game.tscn")
@onready var _creditsScene: PackedScene = preload("res://Scenes/Credits/credits.tscn")
var _loadedInstance: Node
var _sceneToLoad: PackedScene
var _loadQueued: bool:
  get: return _sceneToLoad != null

func _ready() -> void:
  _on_play_clicked() # Pretend we clicked "Play Game"
  await get_tree().create_timer(3.0).timeout
  _on_credits_clicked() # Pretend we accessed the Credits 3 seconds later.

func _on_play_clicked() -> void:
  _queue_load(_gameScene)

func _on_credits_clicked() -> void:
  _queue_load(_creditsScene)

func _queue_load(scene: PackedScene) -> void:
  if _loadQueued:
    return
  _sceneToLoad = scene;

func _load_instance(scene: PackedScene) -> void:
  _loadedInstance = scene.instantiate()
  add_child(_loadedInstance)

func _unload_instance() -> void:
  if _loadedInstance == null or !is_instance_valid(_loadedInstance):
    return
  _loadedInstance.queue_free()

func _process(_delta: float) -> void:
  if !_loadQueued:
    return
  if _loadedInstance != null:
    if is_instance_valid(_loadedInstance):
      _unload_instance()
      return;
    _loadedInstance = null
  if _loadedInstance == null:
    _load_instance(_sceneToLoad)
    _sceneToLoad = null
