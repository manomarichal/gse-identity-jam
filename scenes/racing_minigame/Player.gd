extends RigidBody2D

export var push_speed = 100
export var max_push_speed = 10000

onready var vec = Vector2(push_speed, 0)
	
func _physics_process(delta):
	if Input.is_action_pressed("move_right") and linear_velocity.x < max_push_speed:
		linear_velocity.x = push_speed
	else:
		linear_velocity.x = 0
