class_name Events
extends Node

signal game_started()
signal game_ended()
signal player_fired()
signal player_moved_horizontally(direction: Direction)
signal player_moved_vertically(direction: Direction)

enum Direction {LEFT, RIGHT, UP, DOWN}

func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("move_left"):
    player_moved_horizontally.emit(Direction.LEFT)
  if Input.is_action_just_pressed("move_right"):
    player_moved_horizontally.emit(Direction.RIGHT)
  if Input.is_action_just_pressed("move_up"):
    player_moved_vertically.emit(Direction.UP)
  if Input.is_action_just_pressed("move_down"):
    player_moved_vertically.emit(Direction.DOWN)
  if (Input.is_action_just_pressed("fire")):
    player_fired.emit()
