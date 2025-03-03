## Various globally-defined types

# Included in global scope, so no class_name (must extend Node)
extends Node

## Represents an orthogonal direction
enum Direction {LEFT, RIGHT, UP, DOWN}

const _CONTROLS_TEXT_FILE_PATH: String = "res://Assets/Text/controls.txt"

## Gets what the controls are for the game as player-readable instructions
func get_controls_text() -> String:
  return FileAccess.get_file_as_string(_CONTROLS_TEXT_FILE_PATH).strip_edges()
