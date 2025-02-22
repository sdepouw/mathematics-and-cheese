## Instantiates a given PackedScene into SceneLoader's parent, ensuring
## that the previously-istantiated PackedScene is removed and deleted
## beforehand
class_name SceneLoader
extends Node

var _loadedInstance: Node
var _sceneToLoad: PackedScene
var _loadQueued: bool:
  get: return _sceneToLoad != null

## Emitted whenever a new scene is instantiated and loaded into the parent
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
    _try_unload_instance()
  else:
    _load_instance()
    _sceneToLoad = null

func _load_instance() -> void:
  _loadedInstance = _sceneToLoad.instantiate()
  get_parent().add_child(_loadedInstance)
  instance_loaded.emit(_loadedInstance)

func _try_unload_instance() -> void:
  if _loadedInstance != null and is_instance_valid(_loadedInstance):
    _loadedInstance.queue_free()
