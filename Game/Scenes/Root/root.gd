class_name Root
extends Node

# TODO: Update to monospaced font. Google has a 'pixel' font?
# TODO: Button defaults (theme?): 400x100, pointer cursor
# TODO: 'Main Menu' with 'Start' and 'Credits' (attribute icon, font, license)
# TODO: Bluey credited to "Alblune" https://alblune.com/,
# from "Squakross: Home Squeak Home" https://www.squeakross.cool/

@onready var _sceneLoader: SceneLoader = $SceneLoader
@onready var _splashScreenScene: PackedScene = preload("res://Scenes/SplashScreen/splash_screen.tscn")
@onready var _mainMenuScene: PackedScene = preload("res://Scenes/MainMenu/main_menu.tscn")
@onready var _gameScene: PackedScene = preload("res://Scenes/Game/game.tscn")
@onready var _creditsScene: PackedScene = preload("res://Scenes/Credits/credits.tscn")

func _ready() -> void:
  _sceneLoader.queue_load(_splashScreenScene)
  EventBus.load_main_menu.connect(_load_main_menu)
  EventBus.load_game.connect(_load_game)
  EventBus.load_credits.connect(_load_credits)

func _load_main_menu() -> void:
  _sceneLoader.queue_load(_mainMenuScene)

func _load_game() -> void:
  _sceneLoader.queue_load(_gameScene)

func _load_credits() -> void:
  _sceneLoader.queue_load(_creditsScene)
