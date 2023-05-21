extends Node2D

export var initial_delay = 1.0

func jamp():
	yield(get_tree().create_timer(initial_delay), "timeout")
	$AnimationPlayer.play("jamp")
