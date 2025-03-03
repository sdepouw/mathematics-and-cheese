## Loads various text resources from files

# Included in global scope, so no class_name (must extend Node)
extends Node

const _TEXT_ASSETS_PATH_PREFIX: String = "res://Assets/Text/{filename}.txt"

## Text describing the Player's controls
var controls: String = FileAccess.get_file_as_string(_TEXT_ASSETS_PATH_PREFIX.format({"filename": "controls"}))

## Text shown during credits
var credits: String = FileAccess.get_file_as_string(_TEXT_ASSETS_PATH_PREFIX.format({"filename": "credits"}))

## Text for How to Play
var instructions: String = FileAccess.get_file_as_string(_TEXT_ASSETS_PATH_PREFIX.format({"filename": "instructions"}))
