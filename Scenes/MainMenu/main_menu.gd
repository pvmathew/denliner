extends Node2D

const HOST_SCENE_PATH = "res://Scenes/Host/Host.tscn"
const JOIN_SCENE_PATH = "res://Scenes/Join/Join.tcsn"

var nickname_manager = preload("res://Scenes/MainMenu/nickname_manager.gd").new()

func _ready():
	var nickname = nickname_manager.load_nickname()
	$NicknameInput.text = nickname


func _on_button_pressed():
	get_tree().quit()


func _on_host_pressed():
	get_tree().change_scene_to_file(HOST_SCENE_PATH)
	

func _on_nickname_input_text_changed(new_nickname):
	nickname_manager.save_nickname(new_nickname)
