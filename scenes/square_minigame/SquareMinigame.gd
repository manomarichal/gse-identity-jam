extends Node2D

var player: Node2D
var _stage = 0

func _ready():
	if Global.shape == 0:
		player = $Hexagon
		$Star.queue_free()
		$Moon.queue_free()
		$Heart.queue_free()
	elif Global.shape == 1:
		player = $Star
		$Hexagon.queue_free()
		$Moon.queue_free()	
		$Heart.queue_free()
	elif Global.shape == 2:
		player = $Moon
		$Star.queue_free()
		$Hexagon.queue_free()
		$Heart.queue_free()
	elif Global.shape == 3:
		player = $Heart
		$Star.queue_free()
		$Hexagon.queue_free()
		$Moon.queue_free()	
		
	$Fade.fade_in()
	player.visible = true
	
func _start_game():
	for child in $squares.get_children():
		child.mode = RigidBody2D.MODE_RIGID
	player.replace_by_rigid()
	player.queue_free()
	var i = 2 if Global.shape == 0 else 5
	yield(get_tree().create_timer(i), "timeout")
	if Global.shape == 0:
		start_dialog("SquareFinishGood")
		Global.shapes_placed[0] = true
	else:
		start_dialog("SquareFinish")
	_stage += 1

func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	match(_stage):
		0:
			_start_game()
		1:
			_switch_scene()
			
	
func _switch_scene():
	$Fade.fade_out()

func _on_Fitthing_area_entered(area):
	player.stop_movement = true
	player.global_position = $Fitthing.global_position
	start_dialog("SquareGameStart")
	
func _on_Fade_fade_out():
	if Global.shape == 0:
		get_tree().change_scene("res://scenes/intro/Intro.tscn")
	else:
		Global.depri_percent += 0.2
		get_tree().change_scene("res://scenes/Overworld.tscn")
