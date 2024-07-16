extends Control

@onready var player_list = %VBox

func _ready() -> void:
	initializeUI()
	
	
# Init function for initializing all UI with various player & lobby datas
func initializeUI() -> void:
	$LobbyName.text = SteamLobbyData.lobby_name
	
	var lobby_members = SteamLobbyData.get_lobby_members()
	
	for player in lobby_members:
		var steam_id = player["steam_id"] 
		var steam_name = player["steam_name"]
		var label = Label.new()
		label.text = steam_name
		player_list.add_child(label)
	
