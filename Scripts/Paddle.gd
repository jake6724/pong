class_name Paddle
extends CharacterBody2D

var speed: float = 400

func _physics_process(_delta):
	if Input.is_action_pressed("up"):
		print("up")
		velocity.y =  -speed

	elif Input.is_action_pressed("down"):
		print("down")
		velocity.y = speed
	else:
		velocity.y = 0

	move_and_slide()