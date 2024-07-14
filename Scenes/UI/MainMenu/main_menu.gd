extends Control

const JOIN_SCENE_PATH = "res://Scenes/Join/Join.tcsn"

func _ready():
	PlayerData.load_player_data()
	$NicknameInput.text = PlayerData.nickname
	$Type.text = PlayerData.type


func _on_close_pressed():
	get_tree().quit()


func _on_host_pressed():
	SessionData.start_session()
	

func _on_nickname_input_text_changed(new_nickname):
	pass


func _on_join_pressed():
	SessionData.join_session()


func _on_reset_settings_pressed():
	PlayerData.reset_player_data()


func _on_create_lobby_pressed() -> void:
	print("Creating steam lobby")
	SteamLobbyData.create_lobby()
