extends Node2D

var trigger = false

func _ready():
	$Fade.fade_in()
	start_dialog("ShapeChoice")
		
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
	if Input.is_action_just_pressed("one"):
		Global.shape = 0
		_transition()
	elif Input.is_action_just_pressed("two"):
		Global.shape = 1
		_transition()
	elif Input.is_action_just_pressed("three"):
		Global.shape = 2
		_transition()
	elif Input.is_action_just_pressed("four"):
		Global.shape = 3
		_transition()
