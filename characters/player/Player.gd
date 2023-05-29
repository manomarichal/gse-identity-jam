extends KinematicBody2D

export var move_speed = 500;

var _can_interact = false
var _is_talking = false
var _scene_to_switch = ""
var _has_interacted = false

func _ready():
	print(global_position)
	global_position = Global.player_pos
	$Fade.fade_in()

func _physics_process(delta):
	Global.player_pos_current = global_position
	if _is_talking: return
	var vec = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_and_slide(vec*Vector2(move_speed, move_speed), Vector2.UP)

func _process(delta):
	if _is_talking: return
	if _can_interact and not _has_interacted:
		if $InteractAreaDetector.get_overlapping_areas().size() == 1:
			var area = $InteractAreaDetector.get_overlapping_areas()[0]
			if Global.has_interacted[area.globalInteractIndex]: return
			Global.has_interacted[area.globalInteractIndex] = true
			_has_interacted = true
			_scene_to_switch = area.scene_path
			start_dialog(area.dialog_timeline)

func _on_InteractAreaDetector_area_entered(area):
	_can_interact = true;

func _on_InteractAreaDetector_area_exited(area):
	_can_interact = false;
	_has_interacted = true
	
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

func _on_Fade_fade_out():
	get_tree().change_scene(_scene_to_switch)




