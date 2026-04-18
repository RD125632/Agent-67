extends Node2D

var highscore : int = 0
var currentscore : int = 0

var square_scene : PackedScene = preload("uid://w6eav2tbujmm")
var triangle_scene : PackedScene = preload("uid://ddiue7qxlntk3")
@onready var spawns: Node2D = $Spawns
@onready var label: Label = $CanvasLayer/Label
@onready var high_score_label: Label = $CanvasLayer/Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score_label.text = "HIGHSCORE: " + str(GameManager.highscore)
	pass # Replace with function body.


# CallSpawnObjectsed every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("uid://disnpmhul4mjr")
		print("test")
	pass


func _on_square_timer_timeout() -> void:
	
	var r = randi() % 5   # 0 - 9
	var adjustment = randi_range(-100,100)
	if r > 3:
		
		var square = square_scene.instantiate()
		square.position = Vector2(1300 + adjustment, 536)
		spawns.add_child(square)
	elif r > 1:
		var square = triangle_scene.instantiate()
		square.position = Vector2(1300 + adjustment, 536)
		spawns.add_child(square)
		
	print(r)

	pass # Replace with function body.
	
	


func _on_score_timer_timeout() -> void:
	currentscore += 1
	GameManager.score = currentscore
	label.text = "SCORE: " + str(currentscore)
	pass # Replace with function body.
