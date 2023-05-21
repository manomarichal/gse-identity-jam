extends Area2D

var _exit = false
var player 
var _dialog

func _process(delta):
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
	no_exit()

func _on_Exit_body_entered(body):
	player = body
	player._is_talking = true
	start_dialog("Exit")

func no_exit():
	_dialog.queue_free()
	_dialog = null
	player._is_talking = false
	
func exit():
	print("done")
