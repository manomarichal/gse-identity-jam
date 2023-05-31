extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fade.fade_in()
	var audio = Audio.get_node("AudioStreamPlayer2D")
	while (audio.volume_db < 0):
		audio.volume_db += 0.01
