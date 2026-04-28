extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	return
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Views/GameOver/GameOver.tscn")
