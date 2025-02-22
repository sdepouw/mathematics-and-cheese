## Repository for the High Score, stored in user files

# Included in global scope, so no class_name
extends Node

signal updated(highScore: int)

const _saveLocation: String = "user://highscore.dat";
var _highScore: int = 0

func get_current_high_score() -> int:
  return _highScore

func save_new_high_score(newHighScore: int) -> void:
  _highScore = newHighScore
  var file: FileAccess = FileAccess.open(_saveLocation, FileAccess.WRITE)
  file.store_32(_highScore)
  updated.emit(_highScore)

func _ready() -> void:
  if _load_high_score():
    updated.emit(_highScore)

func _load_high_score() -> bool:
  if !FileAccess.file_exists(_saveLocation):
    return false
  var file: FileAccess = FileAccess.open(_saveLocation, FileAccess.READ)
  _highScore = file.get_32()
  return true
