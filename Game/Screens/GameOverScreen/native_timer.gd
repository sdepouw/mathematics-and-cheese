## A class that uses system time
class_name NativeTimer

var _wait_time: float
var _previous_ticks: int

func _init(wait_time: float) -> void:
  _wait_time = wait_time
  _previous_ticks = Time.get_ticks_msec()

func within_wait_time() -> bool:
  var elapsed: int = Time.get_ticks_msec() - _previous_ticks
  restart()
  return elapsed <= (_wait_time * 1000)

func restart() -> void:
  _previous_ticks = Time.get_ticks_msec()
