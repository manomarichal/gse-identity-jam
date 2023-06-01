extends Node2D

func _ready():
	if  Global.depri_percent == 0:
		start_dialog("Intro")
	if not Global.has_read_intro:
		Global.has_read_intro = true
		Dialogic.set_variable("rintro", "1")
		Audio.get_node("AudioStreamPlayer2D").play()
		
		
func start_dialog(timeline):
	$Player._is_talking = true
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)
	

func _on_event_end(event_type):
	$Player._is_talking = false



