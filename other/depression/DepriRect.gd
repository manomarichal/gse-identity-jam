extends TextureRect

func _process(delta):
	var current_percent = material.get_shader_param("percent") 
	if current_percent != Global.depri_percent:
		material.set_shader_param("percent", current_percent + 0.001*sign(Global.depri_percent-current_percent))
