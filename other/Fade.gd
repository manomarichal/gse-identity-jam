extends CanvasLayer

signal fade_in
signal fade_out

func _ready():
	visible = true

func fade_in():
	$AnimationPlayer.play("fade_in")

func fade_out():
	$AnimationPlayer.play("fade_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		emit_signal("fade_out")
