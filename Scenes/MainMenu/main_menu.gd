extends Node2D

const JOIN_SCENE_PATH = "res://Scenes/Join/Join.tcsn"

var nickname_manager = preload("res://Scenes/MainMenu/nickname_manager.gd").new()
var nickname = nickname_manager.load_nickname()

func _ready():
	$NicknameInput.text = nickname


func _on_close_pressed():
	get_tree().quit()


func _on_host_pressed():
	SessionData.start_session()
	

func _on_nickname_input_text_changed(new_nickname):
	nickname_manager.save_nickname(new_nickname)


func _on_join_pressed():
	SessionData.join_session()
