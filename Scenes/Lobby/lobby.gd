extends Node2D

func _ready():
	SessionData.player_connected.connect(self._on_player_connected)
	SessionData.player_disconnected.connect(self._on_player_disconnected)
	
	$Nickname/Value.text = PlayerData.nickname
	$"IsHost/Value".text = str(PlayerData.is_host)
	
	for player in SessionData.players.values():
		print(player)
		$PlayerList.text += player

func _on_leave_room_pressed():
	SessionData.leave_session()

func _on_send_pressed():
	print("Send button was pressed. Sending the following message: ", $MessageInput.text)
	rpc("msg_rpc", PlayerData.nickname, $MessageInput.text)
	$MessageInput.text = ""

func _on_player_connected(peer_id, player_name):
	$PlayerList.text += player_name + "\n"
	
func _on_player_disconnected(peer_id):
	$PlayerList.text = ""
	for player_name in SessionData.players.values():
		$PlayerList.text += player_name + "\n"
	
	
@rpc ("any_peer", "call_local")
func msg_rpc(nickname, data):
	print("Receiving a message: ", data, "From: ", nickname)
	$ChatLog.text += str(nickname, ":", data, "\n")
	
