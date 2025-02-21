class_name SplashScreen
extends Node

signal splash_scene_ended

func _ready() -> void:
  await get_tree().create_timer(1.5).timeout
  splash_scene_ended.emit()
