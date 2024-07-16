extends Control

@onready var player_list = %VBox

func _ready() -> void:
	Steam.lobby_message.connect(_on_lobby_message)
	initializeUI()
	
	
# Init function for initializing all UI with various player & lobby datas
func initializeUI() -> void:
	$LobbyName.text = SteamLobbyData.lobby_name
	
	var lobby_members = SteamLobbyData.get_lobby_members()
	
	for player in lobby_members:
		var steam_id = player["steam_id"] 
		var steam_name = player["steam_name"]
		var label = Label.new()
		label.text = steam_name
		player_list.add_child(label)
	
func _on_send_pressed() -> void:
	print("Send button was pressed. Sending the following message: ", $MessageInput.text)
	
	# Get the entered chat message
	var this_message: String = $MessageInput.get_text()

	# If there is even a message
	if this_message.length() > 0:
		# Pass the message to Steam
		var was_sent: bool = Steam.sendLobbyChatMsg(SteamLobbyData.lobby_id, this_message)

		# Was it sent successfully?
		if not was_sent:
			print("ERROR: Chat message failed to send.")
			
	$MessageInput.clear()
	

func _on_lobby_message(lobby_id, user_id, buffer, chat_type) -> void:
	var user;
	
	for member in SteamLobbyData.lobby_members:
		if member["steam_id"] == user_id:
			user = member["steam_name"]
			break

	$ChatLog.text += str(user, ":", buffer, "\n")

#lobby_id (uint64_t)
#user (uint64_t)
#buffer (string)
#chat_type (int)
