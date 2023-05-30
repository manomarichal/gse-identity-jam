extends Node2D

var player

signal start_game

var _jamped = false
var _trigger = false

func _ready():
	player = $Player
	$Fade.fade_in()
	start_dialog("TriangleGameStart")

func _process(delta):
	if not _trigger and player.hit_ceiling:
		print("hi")
		_trigger = true
		player.drop_down()
		yield(get_tree().create_timer(2.3), "timeout")
		if Global.shape != 1: 
			start_dialog("JampEnd")
		else:
			start_dialog("TriangleGood")

func start_dialog(timeline):
	player.disable_movement = true
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	if not _jamped:
		emit_signal("start_game")
		_jamped = true
		player.disable_movement = false
	else:
		$Fade.fade_out()

func _on_Fade_fade_out():
	Global.depri_percent += 0.2
	get_tree().change_scene("res://scenes/Overworld.tscn")
