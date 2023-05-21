extends RigidBody2D

export var push_speed = 100
export var max_push_speed = 10000

onready var vec = Vector2(push_speed, 0)

var race = false

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
	Global.depri_percent += 0.3
	get_tree().change_scene("res://scenes/Overworld.tscn")

func _on_Finishline_body_entered(body):
	yield(get_tree().create_timer(1), "timeout")
	race = false
	yield(get_tree().create_timer(1), "timeout")
	start_dialog("RaceEnd")

	
	
	
	
