

class_name LoginHTTPClass extends RefCounted
var name: String
var user_id_1: String
var user_id_2: String

func to_dict() -> Dictionary:
	return {
		"name": name,
		"user_id_1": user_id_1,
		"user_id_2": user_id_2,
	}