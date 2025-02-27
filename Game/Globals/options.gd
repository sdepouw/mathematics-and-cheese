# Included in global scope, so no class_name
extends Node

signal options_loaded(options: OptionValues)

class OptionValues:
  var SoundVolume: float

const _SAVE_LOCATION: String = "user://options.json";
var _default_values: OptionValues
var _current_values: OptionValues

func _ready() -> void:
  _default_values = OptionValues.new()
  _default_values.SoundVolume = 1.0

func _save_current_options() -> void:
  var options_data: String = JSON.stringify(_current_values)
  var file: FileAccess = FileAccess.open(_SAVE_LOCATION, FileAccess.WRITE)
  file.store_line(options_data)

func _save_default_options() -> void:
  _current_values = _default_values
  _save_current_options()

func _load_options() -> void:
  if !FileAccess.file_exists(_SAVE_LOCATION):
    _save_default_options()
  else:
    var json: String = FileAccess.get_file_as_string(_SAVE_LOCATION)
    _current_values = JSON.parse_string(json)
    if not _current_values:
      _save_default_options()
  options_loaded.emit(_current_values)
