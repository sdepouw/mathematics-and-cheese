class_name Main
extends Node

# TODO: Update to monospaced font. Google has a 'pixel' font?
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

func _on_splash_screen_ended() -> void:
  _sceneLoader.queue_load(_mainMenuScene)

func _on_load_game_request() -> void:
  _sceneLoader.queue_load(_gameScene)

func _on_load_credits_request() -> void:
  _sceneLoader.queue_load(_creditsScene)

func _on_scene_loader_instance_loaded(loadedInstance: Node) -> void:
  var mainMenu: MainMenu = loadedInstance as MainMenu
  if mainMenu != null:
    print("It's a main menu!")
    mainMenu.load_game.connect(_on_load_game_request)
    mainMenu.load_credits.connect(_on_load_credits_request)
    return
  var splashScreen: SplashScreen = loadedInstance as SplashScreen
  if splashScreen != null:
    print("It's a splash screen!")
    splashScreen.splash_scene_ended.connect(_on_splash_screen_ended)
  else:
    print("It's something else!")
