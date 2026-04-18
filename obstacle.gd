extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 1180
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Object stopt op -60.
	# Object heeft static velocity.
	#velocity.x = -100
	
	position.x -= 200 * delta
	
	if(position.x < -60) :
		position.x = 1180
	
	
	#move_and_slide()
	pass
