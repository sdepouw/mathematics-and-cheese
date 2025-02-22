## Houses all Signals for the Game Scene
class_name GameEvents
extends Node

## Emitted when a new game starts
signal game_started()
## Emitted when a game ends
signal game_ended()
## Emitted when the player presses the "shoot" button
signal player_shoot()
## Emitted whenever a player presses a movement button (any direction)
signal player_moved(direction: Globals.Direction)

func _process(_delta: float) -> void:
  _map_input_events_to_signals()

func _map_input_events_to_signals() -> void:
  if Input.is_action_just_pressed("move_left"):
    player_moved.emit(Globals.Direction.LEFT)
  if Input.is_action_just_pressed("move_right"):
    player_moved.emit(Globals.Direction.RIGHT)
  if Input.is_action_just_pressed("move_up"):
    player_moved.emit(Globals.Direction.UP)
  if Input.is_action_just_pressed("move_down"):
    player_moved.emit(Globals.Direction.DOWN)
  if Input.is_action_just_pressed("shoot"):
    player_shoot.emit()
