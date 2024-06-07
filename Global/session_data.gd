extends Node

signal player_connected(player_data)
signal player_disconnected(peer_id)

# This will contain player info for every player,
# with the keys being each player's unique IDs.
var players = {}
var num_players = 0

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	
	if PlayerData.is_host:
		players[1] = PlayerData
	player_connected.emit(1, PlayerData)

func start_session():
	PlayerData.is_host = true
	
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(1337)
	if result != OK:
		print("Failed to create server: ", result)
		return
		
	print("Server started successfully on port 1337")
	
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer = peer
	
	players[1] = PlayerData.nickname
	player_connected.emit(1, PlayerData.nickname)

func join_session():
	PlayerData.is_host = false
	
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_client("127.0.0.1", 1337)
	
	if result != OK:
		print("Failed to create client: ", result)
		return
		
	print("Client connected successfully to 127.0.0.1:1337")
	
	get_tree().set_multiplayer(SceneMultiplayer.new(),self.get_path())
	multiplayer.multiplayer_peer = peer

@rpc("any_peer", "reliable")
func _register_player(new_player_data):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_data
	player_connected.emit(new_player_id, new_player_data)

# When a peer connects, send them my player info.
# This allows transfer of all desired data for each player, not only the unique ID.
func _on_player_connected(id):
	print("Player connected: ", id)
	_register_player.rpc_id(id, PlayerData.nickname)

func _on_connected_ok():
	print("Connection was made ok")
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = PlayerData
	player_connected.emit(peer_id, PlayerData.nickname)

func _on_player_disconnected(id):
	print("Player disconnected: ", id)
	players.erase(id)
	player_disconnected.emit(id)
