extends Node2D

func _ready():
	start_dialog("RaceStart")
	$Fade.fade_in()
	if Global.shape == 0:
		$Hexagon.visible = true
	elif Global.shape == 1:
		$Star.visible = true

func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	$Racer.race = true;
	$Racer3.race = true;
	$Racer4.race = true;
	$Racer5.race = true;
	
	if Global.shape == 0:
		$Hexagon.race = true;
	elif Global.shape == 1:
		$Star.race = true



