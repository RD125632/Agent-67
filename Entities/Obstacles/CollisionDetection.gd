extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	print("BODY ENTERED: ", body.name, " type: ", body.get_class())
	
	if not body.is_in_group("CharacterBody2D"):
		return
	get_tree().change_scene_to_file("res://Views/GameOver/GameOver.tscn")
