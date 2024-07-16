extends Control

const JOIN_SCENE_PATH = "res://Scenes/Join/Join.tcsn"

func _ready():
	Steam.lobby_match_list.connect(_on_lobby_match_list)
	Steam.lobby_created.connect(_on_lobby_created)

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


func _on_lobby_list_pressed() -> void:
	SteamLobbyData.request_lobby_List()
	
func _on_lobby_match_list(these_lobbies: Array) -> void:
	for this_lobby in these_lobbies:
		print(this_lobby)
		var lobby_name: String = Steam.getLobbyData(this_lobby, "name")
		var lobby_mode: String = Steam.getLobbyData(this_lobby, "mode")
		#print("Lobby found with name: "+ lobby_name)
#
		## Get the current number of members
		var lobby_num_members: int = Steam.getNumLobbyMembers(this_lobby)
#
		## Create a button for the lobby
		var lobby_button: Button = Button.new()
		lobby_button.set_text("Lobby %s: %s [%s] - %s Player(s)" % [this_lobby, lobby_name, lobby_mode, lobby_num_members])
		lobby_button.set_size(Vector2(800, 50))
		lobby_button.set_name("lobby_%s" % this_lobby)
		lobby_button.connect("pressed", Callable(self, "join_lobby").bind(this_lobby))
#
		## Add the new lobby to the list
		$Lobbies/Scroll/List.add_child(lobby_button)
		
func join_lobby(this_lobby_id: int) -> void:
	SteamLobbyData.join_lobby(this_lobby_id)
	
func _on_lobby_created(connect: int, this_lobby_id: int) -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/Lobby/SteamLobby.tscn")
