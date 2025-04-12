class_name Ball
extends RigidBody2D

var direction: Vector2 = Vector2()
var active_speed: float = GlobalData.ball_initial_speed
var initial_collision: bool = true
var previous_collision: KinematicCollision2D
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	gravity_scale = 0
	direction = get_initial_direction()
	set_palette()

func _process(delta):
	if previous_collision:
		# First collision with a paddle
		if initial_collision and (previous_collision.get_collider() is Paddle or previous_collision.get_collider() is EnemyPaddle):
			active_speed = GlobalData.ball_speed
			GlobalData.enemy_active_speed = GlobalData.enemy_speed

		if  previous_collision.get_collider() is EnemyPaddle:
			previous_collision.get_collider().set_new_move_threshold()
			previous_collision.get_collider().set_move_to_center(true)

		direction = direction.bounce(previous_collision.get_normal())
		previous_collision = null

		GlobalData.play_sound("bounce")

	previous_collision = move_and_collide(Vector2(active_speed, active_speed) * direction * delta)

func get_initial_direction() ->  Vector2:
	var random_angle: float
	# Pick select a random angle from unit circle, within specified ranges.
	# Moving left or right
	if rng.randf() > 0.5:
		if rng.randf() > 0.5:
			# Top Left Quadrant
			random_angle = rng.randf_range(deg_to_rad(135), deg_to_rad(165))
		else:
			# Bottom Left Quadrant
			random_angle = rng.randf_range(deg_to_rad(225), deg_to_rad(195))
	else:
		if rng.randf() > 0.5:
			# Top Right Quadrant
			random_angle = rng.randf_range(deg_to_rad(45), deg_to_rad(15))
		else:
			# Bottom Right Quadrant
			random_angle = rng.randf_range(deg_to_rad(315), deg_to_rad(315))

	return Vector2(cos(random_angle), sin(random_angle))

func reset() -> void:
	position = Vector2(960.0, 560.0)
	direction = get_initial_direction()
	active_speed = GlobalData.ball_initial_speed
	GlobalData.enemy_active_speed = GlobalData.enemy_inital_speed

func set_palette() -> void:
	modulate = GlobalData.active_palette["object"]
