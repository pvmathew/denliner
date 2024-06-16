extends Node2D

var ANIMAL_API_URL = "https://api.github.com/repos/godotengine/godot/releases/latest"
var http_request = HTTPRequest.new()

func _ready():

	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

	if PlayerData.is_host:
		$ThemeList.visible = true
	else:
		$LobbyDisclaimer.visible = true


func _on_どうぶつ_pressed():
	http_request.request(ANIMAL_API_URL)

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	$ThemeList.visible = false
	
	var topic = "うさぎ"
	GameData.topic = topic
	$Topic.text = topic
	
	start_timer()

func start_timer():
	var timer = Timer.new()
	timer.wait_time = 2  # Set the wait time to 10 seconds
	timer.one_shot = true  # Set to true to auto-reset after timeout
	timer.connect("timeout", _on_timeout)
	add_child(timer)  # Add the Timer node to the scene trzee
	timer.start()  # Start the timer

func _on_timeout():
	print("time has run out, showing canvas")
	# This method is called when the timer expires
	# Change to your desired scene after 10 seconds
	get_tree().change_scene_to_file("res://Scenes/Drawing/first_drawing.tscn")
