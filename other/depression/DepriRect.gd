extends TextureRect

func _process(delta):
	material.set_shader_param("percent", 1-Global.depri_percent)
