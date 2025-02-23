## Instantiates a given PackedScene into SceneLoader's parent, ensuring
## that the previously-istantiated PackedScene is removed and deleted
## beforehand
class_name SceneLoader
extends Node

var _loaded_instance: Node
var _scene_to_load: PackedScene
var _load_queued: bool:
  get: return _scene_to_load != null

## Emitted whenever a new scene is instantiated and loaded into the parent
signal instance_loaded(loaded_scene: PackedScene, loaded_instance: Node)

## Queue a PackedScene for loading. The previously-loaded scene will
## be unloaded properly before this scene will load.
## If another PackedScene was queued for loading but never got loaded,
## this new call will take priority.
func queue_load(scene: PackedScene) -> void:
  _scene_to_load = scene;

func _process(_delta: float) -> void:
  if !_load_queued:
    return
  if _loaded_instance != null:
    _try_unload_instance()
  else:
    _load_instance()
    _scene_to_load = null

func _load_instance() -> void:
  _loaded_instance = _scene_to_load.instantiate()
  get_parent().add_child(_loaded_instance)
  instance_loaded.emit(_scene_to_load, _loaded_instance)

func _try_unload_instance() -> void:
  if _loaded_instance != null and is_instance_valid(_loaded_instance):
    _loaded_instance.queue_free()
