extends Node2D

func _ready():
	if not Global.has_read_intro and Global.depri_percent == 0:
		Global.has_read_intro = true
		Dialogic.set_variable("rintro", "1")
	start_dialog("Intro")
		#Audio.get_node("AudioStreamPlayer2D").play()
		
func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)
	$Player._is_talking = true

func _on_event_end(event_type):
	$Player._is_talking = false



