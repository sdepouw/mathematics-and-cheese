class_name GameOverScreen
extends Control

var _score: int
var _best_streak: int

func load_scene_data(data: Variant) -> void:
  # data is Array[int]
  _score = data[0]
  _best_streak = data[1]

func _ready() -> void:
  print("Score! %d | Best Streak! %d" % [_score, _best_streak])
