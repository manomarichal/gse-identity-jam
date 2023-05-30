extends Node2D

	
func _on_TriangleMinigame_start_game():
	for child in get_children():
		child.jamp()
