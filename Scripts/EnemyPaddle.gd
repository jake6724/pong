class_name EnemyPaddle
extends CharacterBody2D

@export var ball: Ball
var speed: float = 500
var move_threshold: float
var range_min: float = 10.0
var range_max: float = 100.0
var frame_count = 1
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	set_new_move_threshold()
	motion_mode = MOTION_MODE_FLOATING
	

func _physics_process(delta):
	# Move up towards ball
	var target_y_velocity: float

	# if ball.position.y < (position.y - move_threshold):
	# 	velocity.y = -speed
	# elif ball.position.y > (position.y + move_threshold):
	# 	velocity.y = speed
	# else:
	# 	velocity.y = 0

	if ball.position.y < (position.y - move_threshold):
		target_y_velocity = -speed
	elif ball.position.y > (position.y + move_threshold):
		target_y_velocity = speed
	else:
		target_y_velocity = 0

	velocity.y = lerp(velocity.y, target_y_velocity, delta * 5)


	move_and_slide()
	frame_count += 1

func set_new_move_threshold() -> void:
	move_threshold = rng.randf_range(range_min, range_max)