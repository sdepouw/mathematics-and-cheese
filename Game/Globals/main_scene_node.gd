## A Node that has a "back_to_menu" signal. Emit when wanting the game
## to return to the main menu screen.
class_name MainSceneNode
extends Node

## A signal to indicate that the game should switch back from the main menu,
## closing the current scene in the process.
signal back_to_menu
