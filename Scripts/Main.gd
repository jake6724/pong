extends Node2D

@onready var ball: Ball = $Ball
@onready var enemy_paddle = $EnemyPaddle
@onready var player_paddle = $PlayerPaddle

func _ready():
	enemy_paddle.ball = ball