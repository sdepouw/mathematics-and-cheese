class_name SplashScreen
extends MainSceneNode

func _ready() -> void:
  await get_tree().create_timer(1.5).timeout
  back_to_menu.emit()
