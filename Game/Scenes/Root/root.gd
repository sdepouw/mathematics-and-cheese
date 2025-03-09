class_name Root extends Node

const _SCREEN_PATH: String = "res://Screens/"

const SPLASH_SCREEN_SCENE: PackedScene = preload(_SCREEN_PATH + "SplashScreen/splash_screen.tscn")
const MAIN_MENU_SCENE: PackedScene = preload(_SCREEN_PATH + "MainMenuScreen/main_menu_screen.tscn")
const OPTIONS_SCENE: PackedScene = preload(_SCREEN_PATH + "OptionsScreen/options_screen.tscn")
const GAME_SCENE: PackedScene = preload(_SCREEN_PATH + "GameScreen/game_screen.tscn")
const INSTRUCTIONS_SCENE: PackedScene = preload(_SCREEN_PATH + "InstructionsScreen/instructions_screen.tscn")
const CREDITS_SCENE: PackedScene = preload(_SCREEN_PATH + "CreditsScreen/credits_screen.tscn")
const GAME_OVER_SCENE: PackedScene = preload(_SCREEN_PATH + "GameOverScreen/game_over_screen.tscn")

@onready var _scene_loader: SceneLoader = $SceneLoader
@onready var _backgroud_parallex: Parallax2D = $BackgroundParallex

const DEFAULT_MOUSE_CURSOR: Resource = preload("res://Assets/Art/bluey/open-paw.png")

func _ready() -> void:
  _scene_loader.queue_load(SPLASH_SCREEN_SCENE)
  EventBus.Screen.load_main_menu.connect(_load_main_menu)
  EventBus.Screen.load_options.connect(_load_options)
  EventBus.Screen.load_game.connect(_load_game)
  EventBus.Screen.load_instructions.connect(_load_instructions)
  EventBus.Screen.load_credits.connect(_load_credits)
  EventBus.Screen.load_game_over.connect(_load_game_over)
  Input.set_custom_mouse_cursor(DEFAULT_MOUSE_CURSOR, Input.CURSOR_ARROW)

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

func _load_game_over(_score: int, _best_streak: int, _cheeses: int) -> void:
  await _scene_loader.queue_load(GAME_OVER_SCENE, [_score, _best_streak, _cheeses])

func _on_scene_loader_instance_loaded(loaded_scene: PackedScene, _loaded_instance: Node) -> void:
  var hide_parallex: bool =\
    loaded_scene == SPLASH_SCREEN_SCENE or\
    loaded_scene == GAME_SCENE
  _backgroud_parallex.visible = !hide_parallex
