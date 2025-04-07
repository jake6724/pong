class_name Ball
extends RigidBody2D

var direction: Vector2 = Vector2()
var speed: float = 1500
var initial_speed: float = speed / 2 
var active_speed: float = initial_speed
var initial_collision: bool = true
var previous_collision: KinematicCollision2D
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	gravity_scale = 0
	direction = get_initial_direction()
	
func _physics_process(delta):
	if previous_collision:
		if initial_collision and (previous_collision.get_collider() is Paddle or previous_collision.get_collider() is EnemyPaddle):
			active_speed = speed

		if  previous_collision.get_collider() is EnemyPaddle:
			previous_collision.get_collider().set_new_move_threshold()

		direction = direction.bounce(previous_collision.get_normal())
		previous_collision = null

	previous_collision = move_and_collide(Vector2(active_speed, active_speed) * direction * delta)

func get_initial_direction() ->  Vector2:
	var random_angle: float
	# Pick select a random angle from unit circle, within specified ranges. If-else selects if right or left moving
	if rng.randf() > 0.5:
		random_angle = rng.randf_range(deg_to_rad(-45), deg_to_rad(45))
	else:
		random_angle = rng.randf_range(deg_to_rad(135), deg_to_rad(225))

	return Vector2(cos(random_angle), sin(random_angle))
