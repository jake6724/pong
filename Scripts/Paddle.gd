class_name Paddle
extends CharacterBody2D

var speed: float = 500

func _ready():
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(_delta):
	if Input.is_action_pressed("up"):
		velocity.y =  -speed

	elif Input.is_action_pressed("down"):
		velocity.y = speed
	else:
		velocity.y = 0

	move_and_slide()
