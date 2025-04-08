extends RigidBody2D

@onready var left_goal:Area2D = $LeftGoal
@onready var right_goal:Area2D = $RightGoal
@onready var center_line: Sprite2D = $CenterLine

signal player_point
signal enemy_point

func _ready():
	left_goal.body_entered.connect(on_enemy_goal_entered)
	right_goal.body_entered.connect(on_player_goal_entered)

func on_enemy_goal_entered(body):
	if body is Ball:
		player_point.emit("player")

func on_player_goal_entered(body):
	if body is Ball:
		enemy_point.emit("enemy")