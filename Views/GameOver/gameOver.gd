extends CanvasLayer
 
@onready var label: Label = $MarginContainer/VBoxContainer/Score
@onready var high_label: Label = $MarginContainer/VBoxContainer/Highscore

@onready var retry_button = $MarginContainer/VBoxContainer/Retry
@onready var exit_button = $MarginContainer/VBoxContainer/Exit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Bind buttons
	retry_button.pressed.connect(_on_retry_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	if GameManager.try_set_highscore() :
		label.text = "NEW HIGH SCORE: " + str(GameManager.score)
	else : 
		label.text = "SCORE: " + str(GameManager.score)
	
	high_label.text = "HIGHSCORE: " + str(GameManager.highscore)

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://xtme3fhwmdqg")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
