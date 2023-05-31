extends KinematicBody2D

export var move_speed = 500;

var _can_interact = false
var _is_talking = false
var _scene_to_switch = ""
var _has_interacted = false
var _dialog_var_to_set = ""

func _ready():
	if Global.shape == 0:
		$Hexagon.visible = true
		Dialogic.set_variable("pn", "Hex")
		Dialogic.set_variable("ps", "hexagon")
		Dialogic.set_variable("pa", "6")
		Dialogic.set_variable("pht", "the Hexagulf")
		Dialogic.set_variable("pcompliment", "You’re not hexed like the other hexagons I met. Your hex is hexagon!")
		Dialogic.set_variable("phex", "Why do these things keep happening to me, am I hexed?")
		Dialogic.set_variable("pinsult", "What are you? A triple square?")
	elif Global.shape == 1:
		$Star.visible = true
		Dialogic.set_variable("pn", "Star")
		Dialogic.set_variable("ps", "star")
		Dialogic.set_variable("pht", "Starkansas")
		Dialogic.set_variable("trianglehat", false)
		Dialogic.set_variable("pcompliment", "You truly were the star!")
		Dialogic.set_variable("phex", "Why do disa-stars keep happening to me?")
		Dialogic.set_variable("pinsult", "What are you? A quintuple triangle?")
	elif Global.shape == 2:
		$Moon.visible = true
		Dialogic.set_variable("pn", "Moon")
		Dialogic.set_variable("ps", "moon")
		Dialogic.set_variable("pht", "Starkansas")
		Dialogic.set_variable("pcompliment", "You truly were the star!")
		Dialogic.set_variable("phex", "Why do disa-stars keep happening to me?")
		Dialogic.set_variable("pinsult", "What are you? A deflated circle?")
	elif Global.shape == 3:
		$Heart.visible = true
		Dialogic.set_variable("pn", "Heart")
		Dialogic.set_variable("ps", "heart")
		Dialogic.set_variable("pht", "Starkansas")
		Dialogic.set_variable("pcompliment", "You truly were the star!")
		Dialogic.set_variable("phex", "Why do disa-stars keep happening to me?")
		Dialogic.set_variable("pinsult", "What are you? A damaged circle?")
		
	global_position = Global.player_pos
	print(global_position)
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
			_dialog_var_to_set = area.dialogReadVar
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
	Dialogic.set_variable(_dialog_var_to_set, "1")
	get_tree().change_scene(_scene_to_switch)




