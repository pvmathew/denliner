extends CanvasLayer

func _ready():
	print(PlayerData.is_onboarded)
	if PlayerData.is_onboarded:
		$Control/Onboarding.hide()
		
