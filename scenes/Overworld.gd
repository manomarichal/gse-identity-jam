extends Node2D

func _ready():
	if Global.depri_percent == 0:
		start_dialog("Intro")
		Audio.get_node("AudioStreamPlayer2D").play()

func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)
	$Player._is_talking = false

func _on_event_end(event_type):
	$Player._is_talking = false



