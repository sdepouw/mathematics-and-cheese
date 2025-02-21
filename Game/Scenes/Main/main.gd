class_name Main
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

func _load_main_menu() -> void:
  _sceneLoader.queue_load(_mainMenuScene)

func _on_load_game_request() -> void:
  _sceneLoader.queue_load(_gameScene)

func _on_load_credits_request() -> void:
  _sceneLoader.queue_load(_creditsScene)

func _on_scene_loader_instance_loaded(loadedInstance: Node) -> void:
  var mainMenu: MainMenu = loadedInstance as MainMenu
  if mainMenu != null:
    mainMenu.load_game.connect(_on_load_game_request)
    mainMenu.load_credits.connect(_on_load_credits_request)
    return
  # TODO: Any "return to main menu on scene end", could we emit "scene unloaded" instead?
  # Each scene would essentially have to self-terminate
  var splashScreen: SplashScreen = loadedInstance as SplashScreen
  if splashScreen != null:
    splashScreen.splash_scene_ended.connect(_load_main_menu)
    return
  var creditsScreen: CreditsScreen = loadedInstance as CreditsScreen
  if creditsScreen != null:
    creditsScreen.credits_ended.connect(_load_main_menu)
