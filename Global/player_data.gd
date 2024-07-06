extends Node

var is_onboarded = false
var type: String = ""
var nickname: String = ""

# --
var is_host = false
var is_ready = false

const CONFIG_FILE_PATH = "user://settings.cfg"

func load_player_data():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	if err == OK:
		if config.has_section_key("player", "nickname"):
			var nickname = config.get_value("player", "nickname")
			PlayerData.nickname = nickname
		if config.has_section_key("player", "is_onboarded"):
			var is_onboarded = config.get_value("player", "is_onboarded")
			PlayerData.is_onboarded = is_onboarded
		if config.has_section_key("player", "type"):
			var type = config.get_value("player", "type")
			PlayerData.type = type
	else:
		# Handle other errors if needed
		print("Error loading config file: ", err)

func save_player_data():
	var config = ConfigFile.new()
	config.set_value("player", "nickname", nickname)
	config.set_value("player", "type", type)
	config.set_value("player", "is_onboarded", is_onboarded)
	
	config.save(CONFIG_FILE_PATH)

func reset_player_data():
	var config = ConfigFile.new()
	config.set_value("player", "nickname", "")
	config.set_value("player", "type", "")
	config.set_value("player", "is_onboarded", false)
	
	config.save(CONFIG_FILE_PATH)
	load_player_data()
