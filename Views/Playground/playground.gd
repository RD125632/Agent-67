extends Node2D

const X_SPAWN = 2000
const Y_LOW = 888  # (Bass/Mid)
const Y_HIGH = 760 # (High)
const X_PLAYER = 256
const PLAYER_SIZE = 32
const SPEED = 400
const BPM = 54

var square_scene : PackedScene = preload("uid://w6eav2tbujmm")
var triangle_scene : PackedScene = preload("uid://ddiue7qxlntk3")

var spectrum: AudioEffectSpectrumAnalyzerInstance
var time_elapsed = 0.0
var audio_started = false
var last_spawned_beat = -1
var last_spawned_sub_beat = -1 # Voeg deze variabele bovenin je script toe bij de rest
var prev_melody_energy = -1
var last_melody_sub_beat  = -1

# Bereken de reistijd (Buffer)
# Afstand (1744) / Snelheid (400) = 4.36 seconden
@onready var travel_time = (X_SPAWN - (X_PLAYER - PLAYER_SIZE)) / float(SPEED)

@onready var spawns: Node2D = $Spawns
@onready var label: Label = $CanvasLayer/ScoreLabel
@onready var high_score_label: Label = $CanvasLayer/HighscoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Luister naar de GameManager voor nieuwe scores
	GameManager.highscores_received.connect(update_highscore_ui)
	GameManager.fetch_highscores()
	# Stop de muziek voor de zekerheid als die al liep
	MusicPlayer.stop()
	
	var bus_idx = AudioServer.get_bus_index("MusicBus")
	spectrum = AudioServer.get_bus_effect_instance(bus_idx, 0)

# CallSpawnObjectsed every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_elapsed += delta
	
	# Muziek starten na de buffer-tijd
	if not audio_started and time_elapsed >= travel_time:
		MusicPlayer.play()
		audio_started = true
		
	# --- HIER DE SPAWN LOGICA (ipv in de Timer) ---
	# Bereken de huidige beat
	var beat_f = time_elapsed * (BPM / 60.0)
	var current_beat = int(floor(beat_f))
	var sub_beat = int(floor(beat_f * 2))

	# Spawn 'Boo' op de hele beats
	if current_beat > last_spawned_beat:
		spawn_obstacle(square_scene, Y_LOW)
		last_spawned_beat = current_beat
	
	# Spawn 'Ba' op de halve beats
	if sub_beat % 2 == 1 and sub_beat > last_spawned_sub_beat:
		#spawn_obstacle(triangle_scene, Y_HIGH)
		last_spawned_sub_beat = sub_beat
	# ----------------------------------------------
	
	# 1. Haal de energie op zoals je al deed
	var melody_energy = spectrum.get_magnitude_for_frequency_range(1000, 3000).length()

	# 2. Bereken de sub_beat voor 16de noten (voor snellere deuntjes)
	# We gebruiken hier 4 sub-beats per tel (bpm/60 * 4)
	var melody_sub_beat = int(floor(time_elapsed * (BPM / 60.0) * 4))

	# 3. De Verbeterde Trigger:
	# Hij mag ALLEEN spawnen als:
	# - De energie hoog genoeg is
	# - We op een NIEUWE 16de noot zitten (geen dubbele spawns op 1 noot)
	if melody_energy > 0.008 and melody_sub_beat > last_melody_sub_beat:
		spawn_obstacle(triangle_scene, 700) # Jouw melodie-hoogte
		last_melody_sub_beat = melody_sub_beat
	
	if Input.is_action_just_pressed("Menu"):
		get_tree().change_scene_to_file("uid://disnpmhul4mjr")

func spawn_obstacle(scene, y_pos):
	if scene == null: return
	var inst = scene.instantiate()
	inst.position = Vector2(X_SPAWN, y_pos)
	add_child(inst)

func _on_obstacle_timer_timeout() -> void:
	return

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
