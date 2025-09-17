## Globally-accessible Signals

# Included in global scope, so no class_name (must extend Node)
extends Node

## Screen-related Events
var Screen: ScreenEventBus = ScreenEventBus.new()
## Player-related Events
var Player: PlayerEventBus = PlayerEventBus.new()

func _process(_delta: float) -> void:
  _map_input_events_to_signals()

func _map_input_events_to_signals() -> void:
  if Input.is_action_just_pressed("move_left"):
    Player.player_moved.emit(Globals.Direction.LEFT)
  if Input.is_action_just_pressed("move_right"):
    Player.player_moved.emit(Globals.Direction.RIGHT)
  if Input.is_action_just_pressed("move_up"):
    Player.player_moved.emit(Globals.Direction.UP)
  if Input.is_action_just_pressed("move_down"):
    Player.player_moved.emit(Globals.Direction.DOWN)
  if Input.is_action_just_pressed("confirm"):
    Player.player_confirm.emit()
  if Input.is_action_just_pressed("cancel"):
    Player.player_cancel.emit()

## Houses all Screen-related Events. Access via EventBus.Screen
class ScreenEventBus:
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

  ## Indicates the game should switch to the Game Over scene,
  ## closing the current scene in the process.
  signal load_game_over(score: int, best_streak: int, cheeses: Dictionary[Globals.CheeseType, int])

## Houses all Player-related Events. Access via EventBus.Player
class PlayerEventBus:

  ## Emitted when the player presses the "confirm" button
  signal player_confirm

  ## Emitted when the player pressed the "cancel" button
  signal player_cancel

  ## Emitted whenever a player presses a movement button (any direction)
  signal player_moved(direction: Globals.Direction)
