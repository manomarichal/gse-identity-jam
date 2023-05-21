extends TextureRect

func _ready():
	if (Global.depri_percent) > 0:
		material.set_shader_param("percent", Global.depri_percent-0.3)

func _process(delta):
	var current_percent = material.get_shader_param("percent") 
	if current_percent != Global.depri_percent:
		material.set_shader_param("percent", current_percent + 0.002*sign(Global.depri_percent-current_percent))
