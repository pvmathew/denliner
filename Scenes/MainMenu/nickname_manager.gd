extends Node

const CONFIG_FILE_PATH = "user://settings.cfg"

func load_nickname():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILE_PATH)
	if err == OK:
		if config.has_section_key("player", "nickname"):
			var nickname = config.get_value("player", "nickname")
			return nickname
	elif err == ERR_FILE_NOT_FOUND:
		# File does not exist, handle accordingly (e.g., set a default value or ignore)
		var nickname = generate_random_nickname()
		save_nickname(nickname)
		return nickname
	else:
		# Handle other errors if needed
		print("Error loading config file: ", err)

func save_nickname(nickname):
	var config = ConfigFile.new()
	config.load(CONFIG_FILE_PATH)
	config.set_value("player", "nickname", nickname)
	config.save(CONFIG_FILE_PATH)

func generate_random_nickname():
	var random_number = randi() % 1000 # Generate a random number between 0 and 999
	return "Player " + str(random_number)
