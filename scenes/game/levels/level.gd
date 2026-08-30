extends Node

signal level_lost
signal level_won(level_path : String)
@warning_ignore("unused_signal")
signal level_changed(level_path : String)
@onready var tutorial_button: Button = $CanvasLayer/TutorialButton

## Optional path to the next level if using an open world level system.
@export_file("*.tscn") var next_level_path : String

func _on_lose_button_pressed() -> void:
	level_lost.emit()

func _on_win_button_pressed() -> void:
	level_won.emit(next_level_path)

func open_tutorials() -> void:
	%TutorialManager.open_tutorials()

func _ready() -> void:
	pass

func _on_tutorial_button_pressed() -> void:
	tutorial_button.icon = preload("uid://p020w7krna17")
	open_tutorials()
