class_name EnemyPaddle
extends CharacterBody2D

@export var ball: Ball
var speed: float = GlobalData.enemy_speed
var move_threshold: float
var move_threshold_min: float =  GlobalData.enemy_move_threshold_min
var move_threshold_max: float = GlobalData.enemy_move_threshold_max
var frame_count = 1
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var prediction_factor: float = 50
var move_to_center: bool = false
var target_y_velocity:float = 0

func _ready():
	# Configure movement/tracking
	set_new_move_threshold()
	motion_mode = MOTION_MODE_FLOATING
	
	# Set palette
	set_palette()

func _physics_process(_delta):
	if GlobalData.current_game_mode == GlobalData.GameMode.PRAC:
		position.y = ball.position.y
		return

	if ball.position.y < (position.y - move_threshold):
		target_y_velocity = -GlobalData.enemy_active_speed
	elif ball.position.y > (position.y + move_threshold):
		target_y_velocity = GlobalData.enemy_active_speed
	else:
		target_y_velocity = 0

	velocity.y = target_y_velocity
	move_and_slide()

func set_new_move_threshold() -> void:
	move_threshold = rng.randf_range(move_threshold_min, move_threshold_max)

func set_move_to_center(value: bool):
	move_to_center = value
	# position.y = move_toward(position.y, 500, 100)

func set_palette() -> void:
	modulate = GlobalData.active_palette["object"]
