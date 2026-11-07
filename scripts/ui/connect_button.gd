extends Button

@export var menu_node:MarginContainer
var ip: String:
	get:
		return menu_node.user_config.server_ip



func _build_url(path: String) -> String:
	var base := ip.strip_edges()
	if base.is_empty():
		return ""
	if not base.contains("://"):
		base = "http://" + base
	return base.trim_suffix("/") + path

func _on_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Server is offline!")
		disabled = false
		return

	var json = JSON.parse_string(body.get_string_from_utf8())
	if response_code == 200:
		print("Server is online")
		var log_in = LoginHTTPClass.new()
		log_in.name = menu_node.user_config.display_name
		log_in.user_id_1 = menu_node.user_config.user_id_1
		log_in.user_id_2 = menu_node.user_config.user_id_2
		json = JSON.stringify(log_in.to_dict())
		headers = ["Content-Type: application/json"]
		var err = $LoginHTTP.request(_build_url("/login"), headers, HTTPClient.METHOD_POST, json)
		if err != OK:
			push_error("Failed to start login request: %s" % error_string(err))
			disabled = false
	else:
		print("Server is offline!")
		disabled = false

func _on_login_result(result, response_code, headers, body):
	disabled = false
	var json = JSON.parse_string(body.get_string_from_utf8())
	menu_node.user_config.jwt = json['token']
	menu_node.save_config_file()
	print("Logged in!")

func connecto_to_server():
	if disabled:
		return
	var url := _build_url("/health")
	if url.is_empty():
		push_error("Server IP is empty. Set it in the menu first.")
		return
	disabled = true
	var err = $HealthCheckHTTP.request(url)
	if err != OK:
		push_error("Failed to start health check request: %s" % error_string(err))
		disabled = false
