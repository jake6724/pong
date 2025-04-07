extends Node2D

@onready var ball: Ball = $Ball
@onready var enemy_paddle = $EnemyPaddle
@onready var player_paddle = $PlayerPaddle
@onready var arena = $Arena

func _ready():
	enemy_paddle.ball = ball
	arena.player_point.connect(on_player_point)
	arena.enemy_point.connect(on_enemy_point)

func on_player_point():
	print("Player scored!")
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")
	# get_tree().change_scene_to_file("res://Scenes/main.tscn")

func on_enemy_point():
	print("Enemy scored!")
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")
	# get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _input(_event):
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

