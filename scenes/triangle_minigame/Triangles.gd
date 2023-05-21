extends Node2D




func _on_Hex_start_game():
	for child in get_children():
		child.jamp()
