extends RigidBody2D

export var push_speed = 100
export var max_push_speed = 10000

onready var vec = Vector2(push_speed, 0)

var race = false
var _goodend = false
		
func _physics_process(delta):
	if not race: return
	if Input.is_action_pressed("move_right") and linear_velocity.x < max_push_speed:
		linear_velocity.x = push_speed
	else:
		linear_velocity.x = 0

func start_dialog(timeline):
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	Dialogic.set_variable("rc", "1")
	if _goodend:
		Global.shapes_placed[2] = true
		get_tree().change_scene("res://scenes/intro/Intro.tscn")
	else:
		Global.depri_percent += 0.2
		get_tree().change_scene("res://scenes/Overworld.tscn")

func _on_Finishline_body_entered(body):
	yield(get_tree().create_timer(1), "timeout")
	race = false
	yield(get_tree().create_timer(1), "timeout")
	if Global.shape != 2:
		start_dialog("RaceEnd")
	else:
		start_dialog("RaceEndGood")
		_goodend = true

	
	
	
	
