extends Node

# 0 == hex, 1 == star, 2 == moon, 3 == heart
var shape = 0
var depri_percent = 0.0;
var player_pos = Vector2(-280, -400)
var player_pos_current = Vector2(-280, -400)

var has_interacted = [false, false, false]
var shapes_placed = [false, false, false, false]

var has_read_intro = false
