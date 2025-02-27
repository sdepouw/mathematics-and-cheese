class_name Root
extends Node

const SPLASH_SCREEN_SCENE: PackedScene = preload("res://Scenes/SplashScreen/splash_screen.tscn")
const MAIN_MENU_SCENE: PackedScene = preload("res://Scenes/MainMenu/main_menu.tscn")
const OPTIONS_SCENE: PackedScene = preload("res://Scenes/OptionsScreen/options_screen.tscn")
const GAME_SCENE: PackedScene = preload("res://Scenes/Game/game.tscn")
const INSTRUCTIONS_SCENE: PackedScene = preload("res://Scenes/InstructionsScreen/instructions_screen.tscn")
const CREDITS_SCENE: PackedScene = preload("res://Scenes/Credits/credits.tscn")

@onready var _scene_loader: SceneLoader = $SceneLoader
@onready var _backgroud_parallex: Parallax2D = $BackgroundParallex

func _ready() -> void:
  _scene_loader.queue_load(SPLASH_SCREEN_SCENE)
  EventBus.load_main_menu.connect(_load_main_menu)
  EventBus.load_options.connect(_load_options)
  EventBus.load_game.connect(_load_game)
  EventBus.load_instructions.connect(_load_instructions)
  EventBus.load_credits.connect(_load_credits)

func _load_main_menu() -> void:
  await _scene_loader.queue_load(MAIN_MENU_SCENE)

func _load_options() -> void:
  await _scene_loader.queue_load(OPTIONS_SCENE)

func _load_game() -> void:
  await _scene_loader.queue_load(GAME_SCENE)

func _load_instructions() -> void:
  await _scene_loader.queue_load(INSTRUCTIONS_SCENE)

func _load_credits() -> void:
  await _scene_loader.queue_load(CREDITS_SCENE)

func _on_scene_loader_instance_loaded(loaded_scene: PackedScene, _loaded_instance: Node) -> void:
  _backgroud_parallex.visible =\
    loaded_scene == MAIN_MENU_SCENE or\
    loaded_scene == CREDITS_SCENE or\
    loaded_scene == INSTRUCTIONS_SCENE or\
    loaded_scene == OPTIONS_SCENE
