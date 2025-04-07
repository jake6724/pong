extends RigidBody2D

@onready var left_goal:Area2D = $LeftGoal
@onready var right_goal:Area2D = $RightGoal

signal player_point
signal enemy_point

func _ready():
	left_goal.body_entered.connect(on_enemy_goal_entered)
	right_goal.body_entered.connect(on_player_goal_entered)

func on_enemy_goal_entered(body):
	if body is Ball:
		print("enemy entered")
		player_point.emit()

func on_player_goal_entered(body):
	if body is Ball:
		print("player entered")
		enemy_point.emit()