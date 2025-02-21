class_name SplashScreen
extends Node

signal splash_scene_ended();

func _ready() -> void:
  await get_tree().create_timer(3.0).timeout
  splash_scene_ended.emit()
