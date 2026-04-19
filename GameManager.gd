extends Node

signal highscores_received(list: Array)

var player_name : String = "Anonymous"
var score : int = 0
var highscores = []
var http_request : HTTPRequest


func _ready() -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	

# Functie om de lijst op te halen (GET)
func fetch_highscores() -> void:
	var url = "https://jouw-api.com"
	var error = http_request.request(url, [], HTTPClient.METHOD_GET)
	
	if error != OK:
		print("Fout bij starten GET verzoek")

# Functie om een nieuwe score te sturen (POST)
func submit_highscore(player_name: String, score: int) -> void:
	var url = "https://jouw-api.com"
	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify({"name": player_name, "score": score})
	
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	
	if error != OK:
		print("Fout bij starten POST verzoek")

func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Netwerkfout! Kan de server niet bereiken. Result code: ", result)
		return

	if response_code == 200:
		var json_text = body.get_string_from_utf8()
		var data = JSON.parse_string(json_text)
		if data is Array:
			highscores = data
			highscores_received.emit(highscores)
	else:
		print("Server antwoordde met foutcode: ", response_code)
