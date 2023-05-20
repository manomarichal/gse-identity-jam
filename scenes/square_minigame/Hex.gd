extends KinematicBody2D

export var move_speed = 500;

var _is_talking = false

func _ready():
	$Fade.fade_in()
	
func _physics_process(delta):
	if _is_talking: return
	var vec = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_and_slide(vec*Vector2(move_speed, move_speed), Vector2.UP)

func start_dialog(timeline):
	_is_talking = true
	Global.player_pos = global_position
	var dialog = Dialogic.start(timeline)
	dialog.connect("event_end", self, "_on_event_end")
	add_child(dialog)

func _on_event_end(event_type):
	_switch_scene()
	
func _switch_scene():
	$Fade.fade_out()

