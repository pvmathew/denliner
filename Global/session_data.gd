extends Node

const MAIN_MENU_SCENE_PATH = "res://Scenes/MainMenu/main_menu.tscn"
const LOBBY_SCENE_PATH = "res://Scenes/Lobby/lobby.tscn"

signal player_connected(player_data)
signal player_disconnected(peer_id)
signal player_ready_changed(peer_id, value)

# This will contain player info for every player,
# with the keys being each player's unique IDs.
var players = {}
var num_players = 0

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)

func start_session():
	PlayerData.is_host = true
	
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(1337)
	if result != OK:
		print("Failed to create server: ", result)
		return
		
	print("Server started successfully on port 1337")
	
	multiplayer.multiplayer_peer = peer
	
	players[1] = {
		"name": PlayerData.nickname,
		"is_ready": false
	}
	player_connected.emit(1, PlayerData.nickname)
	
	get_tree().change_scene_to_file(LOBBY_SCENE_PATH)

func join_session():
	PlayerData.is_host = false
	
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_client("127.0.0.1", 1337)
	
	if result != OK:
		print("Failed to create client: ", result)
		return
		
	print("Client connected successfully to 127.0.0.1:1337")
	
	multiplayer.multiplayer_peer = peer
	
	get_tree().change_scene_to_file(LOBBY_SCENE_PATH)
	
func leave_session():
	multiplayer.multiplayer_peer = null
	players = {}
	get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)
	
func toggle_ready():
	var new_value = not PlayerData.is_ready
	PlayerData.is_ready = new_value
	var peer_id = multiplayer.get_unique_id()
	rpc("change_player_ready", new_value)
	
func is_all_ready():
	for player in players.values():
		if not player["is_ready"]:
			return false
	return true
	
@rpc("any_peer", "call_local")
func change_player_ready(value):
	print("remote sender id from multipler.get_remote_sender_id: ", multiplayer.get_remote_sender_id())
	print("They changed their ready state to: ", value)
	player_ready_changed.emit(multiplayer.get_remote_sender_id(), value)
	

# When a peer connects, send them my player info.
# This allows transfer of all desired data for each player, not only the unique ID.
func _on_player_connected(id):
	print("Player connected: ", id)
	_register_player.rpc_id(id, PlayerData.nickname, PlayerData.is_ready)

@rpc("any_peer", "reliable")
func _register_player(player_name, ready_value):
	var peer_id = multiplayer.get_remote_sender_id()
	players[peer_id] = {
		"name": name,
		"is_ready": ready_value
	}
	player_connected.emit(peer_id, player_name, ready_value)

func _on_connected_ok():
	print("Connection was made ok")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = {
		"name": PlayerData.nickname,
		"is_ready": PlayerData.is_ready
	}
	player_connected.emit(peer_id, PlayerData.nickname, PlayerData.is_ready)

func _on_player_disconnected(id):
	print("Player disconnected: ", id)
	players.erase(id)
	player_disconnected.emit(id)
