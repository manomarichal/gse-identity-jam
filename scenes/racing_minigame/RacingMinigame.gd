extends Node2D

func _ready():
	start_dialog("RaceStart")
	$Fade.fade_in()

func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	$Racer.race = true;
	$Racer3.race = true;
	$Racer4.race = true;
	$Racer5.race = true;
	$Player.race = true;

