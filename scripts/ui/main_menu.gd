extends MarginContainer

const CONFIG_PATH := "user://settings.config"
const KEY_PATH := "user://generated.key"

var config = ConfigFile.new()

var user_config := UserConfig.new()

@onready var display_name_edit: LineEdit = $VBoxContainer/HBoxContainer/VBoxContainer2/LineEdit
@onready var server_ip_edit: LineEdit = $VBoxContainer/HBoxContainer/VBoxContainer/CodeEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var err = config.load(CONFIG_PATH)
	if err	!= OK:
		config = ConfigFile.new()
		user_config.display_name = "player #67"
		user_config.user_id_1 = UUID.new_string()
		user_config.user_id_2 = UUID.new_string()
		user_config.server_ip = "http://example.com"
		save_config_file()
		print("Created new config file!")
	else :
		user_config.display_name = config.get_value("user","display_name", "")
		user_config.user_id_1 = config.get_value('user','user_id_1', "")
		user_config.user_id_2 = config.get_value('user','user_id_2', "")
		
		user_config.server_ip = config.get_value('connection','server_ip', "")

	# Populate the menu fields with the loaded values.
	display_name_edit.text = user_config.display_name
	server_ip_edit.text = user_config.server_ip

func save_config_file():
	config.set_value("user","display_name",user_config.display_name)
	config.set_value('user','user_id_1',user_config.user_id_1)
	config.set_value('user','user_id_2',user_config.user_id_2)
	config.set_value('user','jwt',user_config.jwt)
	
	config.set_value('connection','server_ip',user_config.server_ip)
	config.save(CONFIG_PATH)
