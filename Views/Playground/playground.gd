extends Node2D

var square_scene : PackedScene = preload("uid://w6eav2tbujmm")
var triangle_scene : PackedScene = preload("uid://ddiue7qxlntk3")

@onready var spawns: Node2D = $Spawns
@onready var label: Label = $CanvasLayer/ScoreLabel
@onready var high_score_label: Label = $CanvasLayer/HighscoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Luister naar de GameManager voor nieuwe scores
	GameManager.highscores_received.connect(update_highscore_ui)
	GameManager.fetch_highscores()

# CallSpawnObjectsed every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("uid://disnpmhul4mjr")

func _on_square_timer_timeout() -> void:
	
	var r = randi() % 5   # 0 - 9
	var adjustment = randi_range(-50,50)
	if r > 3:
		
		var square = square_scene.instantiate()
		square.position = Vector2(1300 + adjustment, 900)
		spawns.add_child(square)
	elif r > 1:
		var square = triangle_scene.instantiate()
		square.position = Vector2(1300 + adjustment, 900)
		spawns.add_child(square)

func _on_score_timer_timeout() -> void:
	GameManager.score += 1
	label.text = "SCORE: " + str(GameManager.score)

func update_highscore_ui() -> void:
	if GameManager.highscores.size() > 0:
		# Pak de score van het eerste object in de array
		var top_score = GameManager.highscores[0].get("score", 0)
		high_score_label.text = "HIGHSCORE: " + str(top_score)
	else:
		high_score_label.text = "HIGHSCORE: No data"
