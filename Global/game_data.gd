extends Node

signal drawing_timer_ended
signal player_status_update

var topic = ""

var drawings = {
	# Where each player's finished drawing is stored. Key is the player's peer_id
}

var drawing = []

var peek_drawing = []

func _ready():
	drawing_timer_ended.connect(_on_drawing_timer_ended)
	
@rpc("any_peer")
func update_player_status(status):
	var peer_id = multiplayer.get_remote_sender_id()
	player_status_update.emit(peer_id, status)

func _on_drawing_timer_ended():
	var my_peer_id = multiplayer.get_unique_id()
	rpc("save_drawing_rpc", drawing)
	
	var next_peer_id = 0
	
	var players = SessionData.players
	var peer_ids = players.keys()
	var finished_drawing_peer_ids = drawings.keys()
	
	for id in finished_drawing_peer_ids:
		peer_ids.erase(id)
	
	peer_ids.erase(my_peer_id)
	
	var next_in_line = peer_ids.pick_random()
	pass_along_drawing.rpc_id(next_in_line, drawing)
	
@rpc("any_peer", "call_local")
func save_drawing_rpc(drawing):
	var sender_id = multiplayer.get_remote_sender_id()
	drawings[sender_id] = drawing
	
@rpc("any_peer")
func pass_along_drawing(drawing):
	# show drawing to the next peer in line here
	peek_drawing = drawing
	get_tree().change_scene_to_file("res://Scenes/Drawing/next_drawing.tscn")
	
