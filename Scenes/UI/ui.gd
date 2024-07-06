extends CanvasLayer

func _ready():
	PlayerData.load_player_data()
	if PlayerData.is_onboarded:
		$Control/Onboard.hide()
		
