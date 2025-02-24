extends Node

# 6 Markers for now (9 later)
# Instantiate 6 Equations
const EQUATION_SCENE: PackedScene = preload("res://Scenes/Equation/equation.tscn")

signal equation_selected(answer: int)

func _ready() -> void:
