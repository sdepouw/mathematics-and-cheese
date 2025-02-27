## Repository for the High Score, stored in user files

# Included in global scope, so no class_name
extends Node

signal updated(highScore: int)

const _SAVE_LOCATION: String = "user://highscore.dat";
var _high_score: int = 0

func get_current_high_score() -> int:
  return _high_score

func save_new_high_score(new_high_score: int) -> void:
  _high_score = new_high_score
  var file: FileAccess = FileAccess.open(_SAVE_LOCATION, FileAccess.WRITE)
  file.store_64(_high_score)
  updated.emit(_high_score)

func clear_high_score() -> void:
  save_new_high_score(0)

func _ready() -> void:
  if _load_high_score():
    updated.emit(_high_score)

func _load_high_score() -> bool:
  if !FileAccess.file_exists(_SAVE_LOCATION):
    return false
  var file: FileAccess = FileAccess.open(_SAVE_LOCATION, FileAccess.READ)
  _high_score = file.get_64()
  return true
