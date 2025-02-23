## Globally-accessible Signals

# Included in global scope, so no class_name
extends Node

## A signal to indicate that the game should switch to the main menu,
## closing the current scene in the process.
signal load_main_menu

## A signal to indicate that the game should switch to the main gameplay scene,
## closing the current scene in the process.
signal load_game

## A signal to indicate that the game should switch to the credits scene,
## closing the current scene in the process.
signal load_credits
