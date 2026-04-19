extends CanvasLayer
 
@onready var label: Label = $MarginContainer/VBoxContainer/Score
@onready var high_label: Label = $MarginContainer/VBoxContainer/Highscore
@onready var retry_button: Button = $MarginContainer/VBoxContainer/Retry
@onready var exit_button: Button = $MarginContainer/VBoxContainer/Exit
@onready var highscore_list_container: VBoxContainer = $MarginContainer/VBoxContainer/HighscoreList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Bind buttons
	retry_button.pressed.connect(_on_retry_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	# Luister naar de GameManager voor nieuwe scores
	GameManager.highscores_received.connect(update_highscore_ui)
	
	# Haal de scores direct op bij het laden van het scherm
	GameManager.fetch_highscores()
	
func update_highscore_ui(scores: Array):
	# Maak de lijst leeg
	for child in highscore_list_container.get_children():
		child.queue_free()
	
	# Voeg voor elke score een nieuw label toe
	for entry in scores:
		var player_name = entry.get("name", "Unknown")
		var player_score = entry.get("score", 0)
		
		var score_label = Label.new()
		score_label.text = str(player_name) + ": " + str(player_score)
		score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		highscore_list_container.add_child(score_label)

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://xtme3fhwmdqg")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
