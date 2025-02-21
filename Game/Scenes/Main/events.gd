class_name Events
extends Node

signal game_started()
signal game_ended()
signal player_fired()
signal player_moved(direction: Direction)

enum Direction {LEFT, RIGHT, UP, DOWN}

func _process(_delta: float) -> void:
  _map_input_events_to_signals()

func _map_input_events_to_signals() -> void:
  if Input.is_action_just_pressed("move_left"):
    player_moved.emit(Direction.LEFT)
  if Input.is_action_just_pressed("move_right"):
    player_moved.emit(Direction.RIGHT)
  if Input.is_action_just_pressed("move_up"):
    player_moved.emit(Direction.UP)
  if Input.is_action_just_pressed("move_down"):
    player_moved.emit(Direction.DOWN)
  if Input.is_action_just_pressed("fire"):
    player_fired.emit()
