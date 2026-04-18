extends Node2D
 
@onready var label: Label = $CanvasLayer/MarginContainer/VBoxContainer/Label2
@onready var high_label: Label = $CanvasLayer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if GameManager.try_set_highscore() :
		label.text = "NEW HIGH SCORE: " + str(GameManager.score)
	else : 
		label.text = "SCORE: " + str(GameManager.score)
	
	high_label.text = "HIGHSCORE: " + str(GameManager.highscore)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("uid://xtme3fhwmdqg")
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
