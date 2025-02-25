@icon("res://bluey.png")
class_name BlueyAnswer
extends Node2D

@onready var _answer_label: Label = $ThoughtBubbleSprite/AnswerLabel

## Sets the value Bluey is thinking of
func set_answer(answer: int) -> void:
  _answer_label.text = str(answer)
