extends Node2D

func _ready():
	if PlayerData.is_host:
		$ThemeList.visible = true
	else:
		$LobbyDisclaimer.visible = true
