extends Area2D

export var scene_path = "res://"
export var dialog_timeline = "test"
export var globalInteractIndex = 0;
export var dialogReadVar = "rc"

func _ready():
	if Global.has_interacted[globalInteractIndex]:
		monitorable = false;
