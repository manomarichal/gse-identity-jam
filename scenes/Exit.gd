extends Area2D

var _exit = false
var player 
var _dialog
var _end = 0
	
var audio: AudioStreamPlayer

func _ready():
	audio = Audio.get_node("AudioStreamPlayer2D")
	
func _process(delta):
	var pos = abs(global_position.distance_to(Global.player_pos_current))
	if (pos < 800):
		var vol = max(0, pos-400)/10
		audio.volume_db = -(40-vol)
	if _dialog == null: return
	
	if Input.is_action_just_pressed("one"):
		no_exit()
	elif Input.is_action_just_pressed("two"):
		exit()
	

func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	_dialog = dialog 
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	match(_end):
		0:
			no_exit()
		1:
			var player = get_parent().get_node("Player")
			player.get_node("Fade").fade_out();
			player._is_talking = false	
		2:
			var player = get_parent().get_node("Player")
			player.get_node("Fade").fade_out();
			player._is_talking = false	
			yield(get_tree().create_timer(1.5), "timeout")
			get_tree().change_scene("res://scenes/end/End.tscn")
	

func _on_Exit_body_entered(body):
	player = body
	player._is_talking = true
	start_dialog("Exit")

func no_exit():
	_dialog.queue_free()
	_dialog = null
	player._is_talking = false
	
func exit():
	_dialog.queue_free()
	_dialog = null
	if Global.depri_percent > 0.85:
		Global.depri_percent = 0.01
		start_dialog("GoodEnding")
		_end = 2
	else:
		start_dialog("BadEnding")
		_end = 1
