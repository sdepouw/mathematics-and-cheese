extends Node

@onready var _parallex: Parallax2D = $Parallax2D

static var _current_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
  _parallex.scroll_offset = _current_offset

func _process(_delta: float) -> void:
  _current_offset = _parallex.scroll_offset
