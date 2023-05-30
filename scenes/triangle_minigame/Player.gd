extends KinematicBody2D

export var max_horizontal_acc := 150
export var horizontal_acc := 20
export var gravity := 10
export var max_gravity := 18000
export var friction = 30
export var friction_airborne = 10
export var jump_speed = 10

onready var _PLAYER = get_parent()

export var fall_multiplier := 2.0

signal start_game
signal hit_ceiling

var hit_ceiling = false
var disable_movement = false
var _velocity = Vector2.ZERO
var _can_jump = false
	
func _ready():
	if Global.shape == 0:
		$Hex.visible = true
	elif Global.shape == 1:
		$Star.visible = true
		$Hat.visible = false
	elif Global.shape == 2:
		$Moon.visible = true
	elif Global.shape == 3:
		$Heart.visible = true
	
		
func apply_horizontal_movement(delta, velocity)-> Vector2:
	var dir = (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))
	# apply momevent 
	velocity.x += horizontal_acc*dir
	
	# check for max speed
	if abs(velocity.x) > max_horizontal_acc: 
		velocity.x = max_horizontal_acc*sign(velocity.x)
	
	# apply friction
	if dir == 0:
		velocity.x -= sign(velocity.x)*(friction if is_on_floor() else friction_airborne)
		if abs(velocity.x) < friction: velocity.x = 0
		
	return velocity
	
func apply_gravity(delta, velocity) -> Vector2:
	if velocity.y < max_gravity * delta:
		velocity.y += gravity * delta * fall_multiplier
	return velocity

func _physics_process(delta):
	if disable_movement: return
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			_velocity.y -= jump_speed
			_can_jump = false
		else:
			_can_jump = true
	_velocity = apply_gravity(delta,_velocity)
	_velocity = apply_horizontal_movement(delta,_velocity)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
func drop_down():
	var pos = $Hat.global_position
	var node = $Hat
	remove_child(node)
	get_parent().add_child(node)
	node.global_position = pos
	
	disable_movement = true
	_velocity = Vector2.ZERO
	if Global.shape == 1:
		return
	yield(get_tree().create_timer(1), "timeout")
	disable_movement = false
	yield(get_tree().create_timer(1.3), "timeout")
	horizontal_acc = 0
	jump_speed = 0
	_velocity = Vector2.ZERO
	
	
func _on_Area2D_body_entered(body):
	hit_ceiling = true

