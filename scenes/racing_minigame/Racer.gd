extends RigidBody2D

export var racing_speed = 500;

func _physics_process(delta):
	linear_velocity.x = racing_speed
