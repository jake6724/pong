extends Node2D

@onready var ball: Ball = $Ball
@onready var enemy_paddle = $EnemyPaddle
@onready var enemy_paddle_2 = $EnemyPaddle2
@onready var arena = $Arena

var max_goals: int = 7

func _ready():
	enemy_paddle.ball = ball
	enemy_paddle_2.ball = ball
	arena.player_point.connect(on_goal)
	arena.enemy_point.connect(on_goal)

	arena.center_line.visible = false

func on_goal(_scorer: String):
	ball.reset()