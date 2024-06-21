extends Node

signal drawing_timer_ended

var topic = ""

var drawings = {
	# Where each player's finished drawing is stored. Key is the player's peer_id
}

var drawing = []

func _ready():
	drawing_timer_ended.connect(_on_drawing_timer_ended)

func _on_drawing_timer_ended():
	var peer_id = multiplayer.get_unique_id()
	rpc("save_drawing_rpc", drawing)
	
@rpc("any_peer", "call_local")
func save_drawing_rpc(drawing):
	var sender_id = multiplayer.get_remote_sender_id()
	drawings[sender_id] = drawing
	
