extends Node

var score : int = 0
var highscore : int = 0

func _ready() -> void:
	load_highscore()

func try_set_highscore() -> bool:
	if score > highscore:
		save_highscore()
		load_highscore()
		return true
	return false

func save_highscore() -> void :
	var file = FileAccess.open("res://Views/HighScore/highscore.txt", FileAccess.WRITE)
	file.store_string(str(score))
	
func load_highscore() -> void:
	if not FileAccess.file_exists("res://Views/HighScore/highscore.txt") : 
		highscore = 0

	var file = FileAccess.open("res://Views/HighScore/highscore.txt", FileAccess.READ)
	highscore = int(file.get_as_text())
