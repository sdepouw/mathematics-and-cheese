class_name Main
extends Node

# TODO: Update to monospaced font. Google has a 'pixel' font?
# TODO: 'Main Menu' with 'Start' and 'Credits' (attribute icon, font, license)
# TODO: Bluey credited to "Alblune" https://alblune.com/,
# from "Squakross: Home Squeak Home" https://www.squeakross.cool/

@onready var _sceneLoader: SceneLoader = $SceneLoader
@onready var _splashScreen: SplashScreen = $SplashScreen
@onready var _mainMenuScene: PackedScene = preload("res://Scenes/MainMenu/main_menu.tscn")
@onready var _gameScene: PackedScene = preload("res://Scenes/Game/game.tscn")
@onready var _creditsScene: PackedScene = preload("res://Scenes/Credits/credits.tscn")

func _on_splash_screen_ended() -> void:
  _splashScreen.queue_free()
  _sceneLoader.queue_load(_mainMenuScene)

func _on_play_clicked() -> void:
  _sceneLoader.queue_load(_gameScene)

func _on_credits_clicked() -> void:
  _sceneLoader.queue_load(_creditsScene)
