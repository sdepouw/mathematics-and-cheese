class_name SceneLoader
extends Node

var _loadedInstance: Node
var _sceneToLoad: PackedScene
var _loadQueued: bool:
  get: return _sceneToLoad != null

signal instance_loaded(loadedInstance: Node)

## Queue a PackedScene for loading. The previously-loaded scene will
## be unloaded properly before this scene will load.
## If another PackedScene was queued for loading but never got loaded,
## this new call will take priority.
func queue_load(scene: PackedScene) -> void:
  _sceneToLoad = scene;

func _process(_delta: float) -> void:
  if !_loadQueued:
    return
  if _loadedInstance != null:
    if is_instance_valid(_loadedInstance):
      _unload_instance()
      return;
    _loadedInstance = null
  if _loadedInstance == null:
    _load_instance()
    _sceneToLoad = null

func _load_instance() -> void:
  _loadedInstance = _sceneToLoad.instantiate()
  get_parent().add_child(_loadedInstance)
  instance_loaded.emit(_loadedInstance)

func _unload_instance() -> void:
  if _loadedInstance == null or !is_instance_valid(_loadedInstance):
    return
  _loadedInstance.queue_free()
