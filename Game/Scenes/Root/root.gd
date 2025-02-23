class_name Root
extends Node

# TODO: Button defaults (theme?): 400x100, pointer cursor
# TODO: Update Reticle with custom sprite
# TODO: Sound effects

const SPLASH_SCREEN_SCENE: PackedScene = preload("res://Scenes/SplashScreen/splash_screen.tscn")
const MAIN_MENU_SCENE: PackedScene = preload("res://Scenes/MainMenu/main_menu.tscn")
const GAME_SCENE: PackedScene = preload("res://Scenes/Game/game.tscn")
const CREDITS_SCENE: PackedScene = preload("res://Scenes/Credits/credits.tscn")

@onready var _scene_loader: SceneLoader = $SceneLoader

func _ready() -> void:
  _scene_loader.queue_load(SPLASH_SCREEN_SCENE)
  EventBus.load_main_menu.connect(_load_main_menu)
  EventBus.load_game.connect(_load_game)
  EventBus.load_credits.connect(_load_credits)

func _load_main_menu() -> void:
  _scene_loader.queue_load(MAIN_MENU_SCENE)

func _load_game() -> void:
  _scene_loader.queue_load(GAME_SCENE)

func _load_credits() -> void:
  _scene_loader.queue_load(CREDITS_SCENE)
