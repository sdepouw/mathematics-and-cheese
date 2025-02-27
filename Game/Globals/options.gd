# Included in global scope, so no class_name
extends Node

signal options_loaded(options: OptionValues)

const _SAVE_LOCATION: String = "user://options.json";
var _default_values: OptionValues
var _current_values: OptionValues

func get_default_options() -> OptionValues:
  return OptionValues.from_values(_default_values)

func get_current_options() -> OptionValues:
  return OptionValues.from_values(_current_values)

func save_options(option_values: OptionValues) -> void:
  _current_values = OptionValues.from_values(option_values)
  _save_current_options()

func _ready() -> void:
  _default_values = OptionValues.default()
  _load_options()

func _save_current_options() -> void:
  var options_data: String = JSON.stringify(_current_values.to_dictionary())
  var file: FileAccess = FileAccess.open(_SAVE_LOCATION, FileAccess.WRITE)
  file.store_line(options_data)

func _save_default_options() -> void:
  _current_values = OptionValues.from_values(_default_values)
  _save_current_options()

func _load_options() -> void:
  if !FileAccess.file_exists(_SAVE_LOCATION):
    _save_default_options()
  else:
    var file: FileAccess = FileAccess.open(_SAVE_LOCATION, FileAccess.READ)
    var json: String = file.get_line()
    _current_values = OptionValues.from_json(json)
    if not _current_values:
      _save_default_options()
  options_loaded.emit(OptionValues.from_values(_current_values))

class OptionValues:
  var sound_volume: float

  func to_dictionary() -> Dictionary:
    return {
      "sound_volume": self.sound_volume
    }

  static func from_json(json: String) -> OptionValues:
    var parsed: Variant = JSON.parse_string(json)
    return OptionValues.from_dictionary(parsed)

  static func from_dictionary(dict: Variant) -> OptionValues:
    var vals: OptionValues = OptionValues.new()
    if not dict:
      return vals
    vals.sound_volume = dict["sound_volume"]
    return vals

  static func from_values(other: OptionValues) -> OptionValues:
    return OptionValues.from_dictionary(other.to_dictionary())

  static func default() -> OptionValues:
    var default_values: OptionValues = OptionValues.new()
    default_values.sound_volume = 1.0
    return default_values
