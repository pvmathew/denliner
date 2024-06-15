extends Node2D

var player_labels = {}

func _ready():
	SessionData.player_connected.connect(self._on_player_connected)
	SessionData.player_disconnected.connect(self._on_player_disconnected)
	SessionData.player_ready_changed.connect(self._on_player_ready_changed)
	SessionData.game_started.connect(self._on_game_started)
	
	# For Debug purposes, shows player info in top left
	$Nickname/Value.text = PlayerData.nickname
	$"IsHost/Value".text = str(PlayerData.is_host)
	
	if PlayerData.is_host:
		$StartGame.visible = true
	
	for player in SessionData.players.values():
		print(player)
		$PlayerList.text += player.name + "\n"
		
		
	for peer_id in SessionData.players.keys():
		var label = Label.new()
		label.text = SessionData.players[peer_id].name
		$PlayerListVBox.add_child(label)
		player_labels[peer_id] = label
		print(player_labels)
		
		
# UI Signals
func _on_leave_room_pressed():
	SessionData.leave_session()

func _on_ready_pressed():
	SessionData.toggle_ready()

func _on_send_pressed():
	print("Send button was pressed. Sending the following message: ", $MessageInput.text)
	rpc("msg_rpc", PlayerData.nickname, $MessageInput.text)
	$MessageInput.text = ""
	
func _on_start_game_pressed():
	SessionData.start_game()

# RPC Signals
func _on_player_connected(peer_id, player_name, ready_value):
	$PlayerList.text += player_name + "\n"
	var label = Label.new()
	label.text = player_name
	$PlayerListVBox.add_child(label)
	player_labels[peer_id] = label
	
func _on_player_disconnected(peer_id):
	$PlayerList.text = ""
	for player in SessionData.players.values():
		$PlayerList.text += player.name + "\n"
		
	if player_labels.has(peer_id):
		var label = player_labels[peer_id]
		$PlayerListVBox.remove_child(label)
		label.queue_free()
		player_labels.erase(peer_id)
		
func _on_player_ready_changed(peer_id, value):
	print(multiplayer.get_unique_id())
	print("Player with peer_id: ", peer_id, "  has changed their ready state to: ", value)
	print(player_labels)
	if player_labels.has(peer_id):
		var label = player_labels[peer_id]
		if value:
			label.add_theme_color_override("font_color", Color.GREEN)
		else:
			label.add_theme_color_override("font_color", Color.WHITE)
			
	print(SessionData.is_all_ready())
			
	if SessionData.is_all_ready():
		$StartGame.disabled = false
	else:
		$StartGame.disabled = true
		
func _on_game_started():
	print("Game has started")
	get_tree().change_scene_to_file("res://Scenes/ThemeSelection/theme_selection.tscn")
	
@rpc ("any_peer", "call_local")
func msg_rpc(name, data):
	$ChatLog.text += str(name, ":", data, "\n")
