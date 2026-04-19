extends CanvasLayer

@onready var start_button : Button = $MarginContainer/VBoxContainer/Start
@onready var player_name : LineEdit = $MarginContainer/VBoxContainer/PlayerName

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	GameManager.player_name = player_name.text
	get_tree().change_scene_to_file("res://Views/Playground/Playground.tscn")
