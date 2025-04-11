extends RigidBody2D

@onready var left_goal:Area2D = $LeftGoal
@onready var right_goal:Area2D = $RightGoal
@onready var top_line: Sprite2D = $TopLine
@onready var bottom_line: Sprite2D = $BottomLine
@onready var center_line: Sprite2D = $CenterLine
@onready var background: Sprite2D = $Background

signal player_point
signal enemy_point

func _ready():
	left_goal.body_entered.connect(on_enemy_goal_entered)
	right_goal.body_entered.connect(on_player_goal_entered)

	set_palette()

func on_enemy_goal_entered(body):
	if body is Ball:
		player_point.emit("player")

func on_player_goal_entered(body):
	if body is Ball:
		enemy_point.emit("enemy")

func set_palette() -> void:
	center_line.modulate = GlobalData.active_palette["object"]
	top_line.modulate = GlobalData.active_palette["object"]
	bottom_line.modulate = GlobalData.active_palette["object"]
	background.modulate = GlobalData.active_palette["background"]
