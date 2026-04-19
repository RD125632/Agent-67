extends CharacterBody2D

const JUMP_VELOCITY = -1000.0
const TERMINAL_VELOCITY = 1000.0 # Voorkomt dat hij oneindig versnelt

var jump_buffer_time: float = 0.15 # Hoe lang hij de input onthoudt
var jump_buffer_counter: float = 0.0

func _physics_process(delta: float) -> void:
	
	# 1. Zwaartekracht
	if not is_on_floor():
		var gravity = get_gravity().y
		# Als we omhoog gaan maar de knop loslaten, vallen we sneller (short jump)
		if velocity.y < 0 and not Input.is_action_pressed("Jump"):
			velocity.y += gravity * 4 * delta
		else:
			velocity.y += gravity * 2 * delta
	velocity.y = min(velocity.y, TERMINAL_VELOCITY)

	# 2. Input Buffering
	if Input.is_action_pressed("Jump"):
		jump_buffer_counter = jump_buffer_time
	else:
		jump_buffer_counter -= delta

	# 3. Jump
	if jump_buffer_counter > 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_buffer_counter = 0 # Reset buffer na jump

	move_and_slide()
