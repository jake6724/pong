class_name EnemyPaddle
extends CharacterBody2D

@export var ball: Ball
var speed: float = GlobalData.enemy_speed
var move_threshold: float
var move_threshold_min: float =  GlobalData.enemy_move_threshold_min
var move_threshold_max: float = GlobalData.enemy_move_threshold_max
var frame_count = 1
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	set_new_move_threshold()
	motion_mode = MOTION_MODE_FLOATING
	

func _physics_process(delta):
	# Move up towards ball
	var target_y_velocity: float

	# if ball.position.y < (position.y - move_threshold):
	# 	velocity.y = -speed * delta * 60
	# elif ball.position.y > (position.y + move_threshold):
	# 	velocity.y = speed * delta * 60
	# else:
	# 	velocity.y = 0

	if ball.position.y < (position.y - move_threshold):
		target_y_velocity = -speed
	elif ball.position.y > (position.y + move_threshold):
		target_y_velocity = speed
	else:
		target_y_velocity = 0

	velocity.y = lerp(velocity.y, target_y_velocity, delta * 10)


	move_and_slide()
	frame_count += 1

func set_new_move_threshold() -> void:
	move_threshold = rng.randf_range(move_threshold_min, move_threshold_max)
