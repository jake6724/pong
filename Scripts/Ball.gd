class_name Ball
extends RigidBody2D

var direction: Vector2 = Vector2()
var speed: float = 1500
var initial_speed: float = speed * .33
var active_speed: float = initial_speed
var initial_collision: bool = true
var previous_collision: KinematicCollision2D
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()
var ball_audio_bus_index: int
var bounce_sound: AudioStream = preload("res://Audio/ball_bounce.wav")

func _ready():
	gravity_scale = 0
	direction = get_initial_direction()
	add_child(audio_player)
	audio_player.stream = bounce_sound
	audio_player.bus = "Ball"
	ball_audio_bus_index = AudioServer.get_bus_index("Ball")

	var effect = AudioServer.get_bus_effect(ball_audio_bus_index, 0)
	effect.pitch_scale = 1.0

func _process(delta):
	if previous_collision:
		if initial_collision and (previous_collision.get_collider() is Paddle or previous_collision.get_collider() is EnemyPaddle):
			active_speed = speed

		if  previous_collision.get_collider() is EnemyPaddle:
			previous_collision.get_collider().set_new_move_threshold()

		direction = direction.bounce(previous_collision.get_normal())
		previous_collision = null

		var effect = AudioServer.get_bus_effect(ball_audio_bus_index, 0)
		effect.pitch_scale = rng.randf_range(1,1.5)

		# audio_player.play()

	previous_collision = move_and_collide(Vector2(active_speed, active_speed) * direction * delta)

func get_initial_direction() ->  Vector2:

	# TODO: make sure it isn't 0
	var random_angle: float
	# Pick select a random angle from unit circle, within specified ranges. If-else selects if right or left moving
	if rng.randf() > 0.5:
		random_angle = rng.randf_range(deg_to_rad(-45), deg_to_rad(45))
	else:
		random_angle = rng.randf_range(deg_to_rad(135), deg_to_rad(225))

	return Vector2(cos(random_angle), sin(random_angle))

func reset() -> void:
	position = Vector2(960.0, 560.0)
	direction = get_initial_direction()
	active_speed = initial_speed
