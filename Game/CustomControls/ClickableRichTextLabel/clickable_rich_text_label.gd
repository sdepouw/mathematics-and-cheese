## Extends RichTextLabel, making any hyperlinks created open within the
## browser or operating system. (The default behavior is to no-op.)
class_name ClickableRichTextLabel extends RichTextLabel

func _ready() -> void:
  # HTML5 automatically handles this event correctly.
  if OS.get_name() != "HTML5":
    self.meta_clicked.connect(OS.shell_open)
