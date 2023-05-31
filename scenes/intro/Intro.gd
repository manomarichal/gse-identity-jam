extends Node2D

var trigger = false

func _ready():
	
	$Fade.fade_in()
	
		
	var h = Global.shapes_placed
	if h[0] and h[1] and h[2] and h[3]:
		get_tree().change_scene("res://scenes/end/End.tscn")
		
	var audio = Audio.get_node("AudioStreamPlayer2D")
	while (audio.volume_db < 0):
		audio.volume_db += 0.01
			
	$Fade.fade_in()
	start_dialog("ShapeChoice")
	Global.depri_percent = 0
	Global.has_interacted = [false, false, false]
	Global.player_pos = Vector2(-280, -400)


	if h[0]:
		Dialogic.set_variable("ci", "[color=green](1) Hexagon[/color]")
	else:
		Dialogic.set_variable("ci", "(1) Hexagon")
		
	if h[1]:
		Dialogic.set_variable("si", "[color=green](2) Star[/color]")
	else:
		Dialogic.set_variable("si", "(2) Star")
		
	if h[2]:
		Dialogic.set_variable("mi", "[color=green](3) Moon[/color]")
	else:
		Dialogic.set_variable("mi", "(3) Moon")
		
	if h[3]:
		Dialogic.set_variable("hi", "[color=green](4) Heart[/color]")
	else:
		Dialogic.set_variable("hi", "(4) Heart")
		
func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	_transition()

func _on_Fade_fade_out():
	get_tree().change_scene("res://scenes/Overworld.tscn")

func _transition():
	if not trigger:
		$Fade.fade_out()
		trigger = true
	
func _process(delta):
	if trigger: return
	var sarray = Global.shapes_placed
	if not sarray[0] and Input.is_action_just_pressed("one"):
		Global.shape = 0
		_transition()
	elif not sarray[1] and Input.is_action_just_pressed("two"):
		Global.shape = 1
		_transition()
	elif not sarray[2] and Input.is_action_just_pressed("three"):
		Global.shape = 2
		_transition()
	elif not sarray[3] and Input.is_action_just_pressed("four"):
		Global.shape = 3
		_transition()
