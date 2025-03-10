class_name EquationRow extends Node2D

@onready var _col_1: Marker2D = $Col1
@onready var _col_2: Marker2D = $Col2
@onready var _col_3: Marker2D = $Col3

func map_to_positions(equation_1: Equation, equation_2: Equation, equation_3: Equation) -> void:
  equation_1.global_position = _col_1.global_position
  equation_2.global_position = _col_2.global_position
  equation_3.global_position = _col_3.global_position
