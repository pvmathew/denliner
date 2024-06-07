extends Node2D

func _ready():
	SessionData.player_connected.connect(self._on_player_connected)
	$Nickname/Value.text = PlayerData.nickname
	$"IsHost/Value".text = str(PlayerData.is_host)
	
	for player in SessionData.players.values():
		print(player)
		$PlayerList.text += player

func _on_leave_room_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")

func _on_send_pressed():
	print("Send button was pressed. Sending the following message: ", $MessageInput.text)
	rpc("msg_rpc", PlayerData.nickname, $MessageInput.text)
	$MessageInput.text = ""

func _on_player_connected(peer_id, player_name):
	$PlayerList.text += player_name + "\n"
	
@rpc ("any_peer", "call_local")
func msg_rpc(nickname, data):
	print("Receiving a message: ", data, "From: ", nickname)
	$ChatLog.text += str(nickname, ":", data, "\n")
	
