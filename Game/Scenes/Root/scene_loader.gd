## Instantiates a given PackedScene into SceneLoader's parent, ensuring
## that the previously-istantiated PackedScene is removed and deleted
## beforehand
class_name SceneLoader
extends Node

var _loaded_instance: Node
var _scene_to_load: PackedScene
var _data_for_scene_to_load: Variant
var _load_queued: bool:
  get: return _scene_to_load != null

## Emitted whenever a new scene is instantiated and loaded into the parent
signal instance_loaded(loaded_scene: PackedScene, loaded_instance: Node)

## Queue a PackedScene for loading. The previously-loaded scene will
## be unloaded properly before this scene will load.
## If another PackedScene was queued for loading but never got loaded,
## this new call will take priority.
func queue_load(scene: PackedScene, data_for_scene: Variant = null) -> void:
  # HACK: Allow any sound effects to play
  await get_tree().create_timer(.15).timeout
  _scene_to_load = scene;
  _data_for_scene_to_load = data_for_scene

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
  # If we're given data to pass along, and the scene has func "load_scene_data(data: Variant)", call it
  if _data_for_scene_to_load != null && _instance_has_load_scene_data_method(_loaded_instance):
    @warning_ignore("unsafe_method_access")
    _loaded_instance.load_scene_data(_data_for_scene_to_load)
  get_parent().add_child(_loaded_instance)
  instance_loaded.emit(_scene_to_load, _loaded_instance)

func _try_unload_instance() -> void:
  if _loaded_instance != null and is_instance_valid(_loaded_instance):
    _loaded_instance.queue_free()

func _instance_has_load_scene_data_method(instance: Node) -> bool:
  var methods: Array[Dictionary] = instance.get_method_list()
  var load_method_metadata: Dictionary
  for method: Dictionary in methods:
    if method["name"] == "load_scene_data":
      load_method_metadata = method
      break
  if not load_method_metadata:
    return false
  var args: Array[Dictionary] = load_method_metadata["args"]
  if args.size() != 1:
    return false
  var argument: Dictionary = args[0]
  return argument["name"] == "data" and argument["type"] == TYPE_NIL
