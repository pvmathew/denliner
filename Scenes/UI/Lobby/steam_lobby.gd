extends Control

func _ready() -> void:
	$LobbyName.text = SteamLobbyData.lobby_name
