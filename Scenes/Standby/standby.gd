extends Control

func _ready():
	GameData.player_status_update.connect(_on_player_status_update)
	$CurrentStatus.text = "The leader is currently thinking about how to draw the topic"
	
	
func _on_player_status_update(peer_id, status):
	$CurrentStatus.text = "Peer with id %d is currently %s" % [peer_id, status]
	
	
