class_name CheeseBody extends RigidBody2D

const CHEDDAR: Resource = preload("res://Assets/Art/cheese/cheddar.png")
const QUESO_FRESCO: Resource = preload("res://Assets/Art/cheese/cheddar.png")
const SWISS: Resource = preload("res://Assets/Art/cheese/cheddar.png")
const PEPPER_JACK: Resource = preload("res://Assets/Art/cheese/cheddar.png")
const MIMOLETTE: Resource = preload("res://Assets/Art/cheese/cheddar.png")
const BLUE: Resource = preload("res://Assets/Art/cheese/cheddar.png")
const GRUYERE: Resource = preload("res://Assets/Art/cheese/cheddar.png")
const BRIE: Resource = preload("res://Assets/Art/cheese/cheddar.png")

@onready var _cheese_sprite: Sprite2D = $CheeseSprite

var _cheese_type: Globals.CheeseType;

func set_cheese_type(cheese_type: Globals.CheeseType) -> void:
  _cheese_type = cheese_type

func _ready() -> void:
  match _cheese_type:
    Globals.CheeseType.CHEDDAR:
      _cheese_sprite.texture = CHEDDAR
    Globals.CheeseType.QUESO_FRESCO:
      _cheese_sprite.texture = QUESO_FRESCO
    Globals.CheeseType.SWISS:
      _cheese_sprite.texture = SWISS
    Globals.CheeseType.PEPPER_JACK:
      _cheese_sprite.texture = PEPPER_JACK
    Globals.CheeseType.MIMOLETTE:
      _cheese_sprite.texture = MIMOLETTE
    Globals.CheeseType.BLUE:
      _cheese_sprite.texture = BLUE
    Globals.CheeseType.GRUYERE:
      _cheese_sprite.texture = GRUYERE
    Globals.CheeseType.BRIE:
      _cheese_sprite.texture = BRIE
