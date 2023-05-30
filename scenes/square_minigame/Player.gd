extends KinematicBody2D

var R = preload("res://scenes/square_minigame/PlayerRigid.tscn")

export var move_speed = 500;

var stop_movement = false

	
func _physics_process(delta):
	if stop_movement: return
	var vec = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_and_slide(vec*Vector2(move_speed, move_speed), Vector2.UP)

func replace_by_rigid():
	var r: RigidBody2D = R.instance()
	get_parent().call_deferred("add_child", r)
	r.global_position = global_position
	r.get_node("CollisionPolygon2D").polygon = $CollisionPolygon2D.polygon
	r.get_node("CollisionPolygon2D").scale = $CollisionPolygon2D.scale
	r.get_node("Sprite").texture = $Sprite.texture
	r.get_node("Sprite").scale = $Sprite.scale


