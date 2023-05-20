extends RigidBody2D

export var push_speed = 100
export var max_push_speed = 10000

onready var vec = Vector2(push_speed, )

func _ready():
	$CollisionPolygon2D.polygon = $Path2D.curve.tessellate()
	add_central_force(vec)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("move_right") and linear_velocity.x < max_push_speed:
		pass
	

