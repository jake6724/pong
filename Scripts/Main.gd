extends Node2D

@onready var ball: Ball = $Ball
@onready var enemy_paddle = $EnemyPaddle
@onready var player_paddle = $PlayerPaddle
@onready var arena = $Arena
@onready var player_score = $ScoreUI/MarginContainer/HBoxContainer/PlayerScore
@onready var enemy_score = $ScoreUI/MarginContainer/HBoxContainer/EnemyScore

var max_goals: int = 7

func _ready():
	enemy_paddle.ball = ball
	arena.player_point.connect(on_goal)
	arena.enemy_point.connect(on_goal)

func on_goal(scorer: String):
	ball.reset()
	var new_score: int
	if scorer == "player":
		new_score = int(player_score.text) + 1
		player_score.text = str(new_score)
	elif scorer == "enemy":
		new_score = int(enemy_score.text) + 1
		enemy_score.text = str(new_score)

	if new_score >= max_goals:
		print("game over")
		# get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")

func _input(_event):
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

# get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")
