extends LineEdit

@export var menu_node: MarginContainer

func _ready() -> void:
	text_changed.connect(_on_text_changed)

func _on_text_changed(txt: String) -> void:
	print("Display name changed!")
	if menu_node:
		menu_node.user_config["display_name"] = txt
		menu_node.save_config_file()
	else:
		push_warning("menu_node is not assigned in the Inspector")
