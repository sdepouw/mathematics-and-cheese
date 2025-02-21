class_name Main
extends Node

# TODO: Update to monospaced font. Google has a 'pixel' font?
# TODO: 'Main Menu' with 'Start' and 'Credits' (attribute icon, font, license)
# TODO: Bluey credited to "Alblune" https://alblune.com/,
# from "Squakross: Home Squeak Home" https://www.squeakross.cool/

@onready var _gameScene: PackedScene = preload("res://Scenes/Game/game.tscn")
var _gameInstance: Game

func _ready() -> void:
  _play_game() # TODO: Menu item

func _play_game() -> void:
  _gameInstance = _gameScene.instantiate()
  add_child(_gameInstance) # calls _ready(), etc. at this moment

func _exit_game() -> void:
  if !is_instance_valid(_gameInstance):
    return
  _gameInstance.queue_free()
