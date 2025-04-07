class_name EnemyPaddle
extends CharacterBody2D

@export var ball: Ball
var speed: float = 100

func _physics_process(delta):
	# Never miss, move as fast as needed
	var new_position = position.move_toward(ball.position, speed)
	position = Vector2(position.x, new_position.y)




	pass
