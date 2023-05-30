extends RigidBody2D

export var racing_speed = 500;

var race = false
	
func _physics_process(delta):
	if race:
		linear_velocity.x = racing_speed
