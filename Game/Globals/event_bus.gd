## Globally-accessible Signals

# Included in global scope, so no class_name
extends Node

## Indicates the game should switch to the main menu,
## closing the current scene in the process.
signal load_main_menu

## Indicates the game should switch to the options scene,
## closing the current scene in the process.
signal load_options

## Indicates the game should switch to the main gameplay scene,
## closing the current scene in the process.
signal load_game

## Indicates the game should switch to the instructions scene,
## closing the current scene in the process.
signal load_instructions

## Indicates the game should switch to the credits scene,
## closing the current scene in the process.
signal load_credits

## Emitted when the player presses the "confirm" button
signal player_confirm

## Emitted when the player pressed the "cancel" button
signal player_cancel

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
  if Input.is_action_just_pressed("confirm"):
    player_confirm.emit()
  if Input.is_action_just_pressed("cancel"):
    player_cancel.emit()
