extends LineEdit


@export var menu_node : MarginContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_changed.connect(_on_text_changed)
	pass # Replace with function body.
	
func _on_text_changed(txt:String)-> void:
	print("server ip changed!")
	if menu_node:
		menu_node.user_config.server_ip = txt
		menu_node.save_config_file()
	else:
		print("Menu script not assigned")
