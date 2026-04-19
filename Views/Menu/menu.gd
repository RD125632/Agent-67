extends CanvasLayer

@onready var single_player_button = $MarginContainer/VBoxContainer/SinglePlayer
@onready var duo_player_button = $MarginContainer/VBoxContainer/DuoPlayer
@onready var exit_button = $MarginContainer/VBoxContainer/Exit

func _ready() -> void:
	single_player_button.pressed.connect(_on_singleplayer_button_pressed)
	duo_player_button.pressed.connect(_on_duoplayer_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

func _on_singleplayer_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://xtme3fhwmdqg")

func _on_duoplayer_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://xtme3fhwmdqg")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
