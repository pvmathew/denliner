extends Node

signal drawing_timer_ended
signal player_status_update

var topic = ""

var drawings = {
	# Where each player's finished drawing is stored. Key is the player's peer_id
}

var drawing = []

func _ready():
	drawing_timer_ended.connect(_on_drawing_timer_ended)
	
@rpc("any_peer")
func update_player_status(status):
	var peer_id = multiplayer.get_remote_sender_id()
	player_status_update.emit(peer_id, status)

func _on_drawing_timer_ended():
	var peer_id = multiplayer.get_unique_id()
	rpc("save_drawing_rpc", drawing)
	
@rpc("any_peer", "call_local")
func save_drawing_rpc(drawing):
	var sender_id = multiplayer.get_remote_sender_id()
	drawings[sender_id] = drawing
	
