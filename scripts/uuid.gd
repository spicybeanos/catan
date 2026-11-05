class_name UUID extends RefCounted
static func new_string() -> String:
	var cr = Crypto.new()
	var bts = cr.generate_random_bytes(16)
	var s : String= ""
	for b in bts:
		s += "%x" % b
	return s
