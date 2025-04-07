class_name Ball
extends RigidBody2D

var direction: Vector2 = Vector2()
var speed: float = 1200
var previous_collision: KinematicCollision2D

func _ready():
	gravity_scale = 0
	direction = Vector2(-.75, .25)

func _physics_process(delta):
	if previous_collision:
		direction = direction.bounce(previous_collision.get_normal())
		previous_collision = null

	previous_collision = move_and_collide(Vector2(speed, speed) * direction * delta)
