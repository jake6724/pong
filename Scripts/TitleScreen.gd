extends Node2D

@onready var ball: Ball = $Ball
@onready var enemy_paddle = $EnemyPaddle
@onready var enemy_paddle_2 = $EnemyPaddle2
@onready var arena = $Arena
@onready var ui = $TitleScreenUI
var max_goals: int = 7

func _ready():
	enemy_paddle.ball = ball
	enemy_paddle_2.ball = ball
	arena.player_point.connect(on_goal)
	arena.enemy_point.connect(on_goal)

	arena.center_line.visible = false

	ui.mode_selected.connect(on_mode_selected)

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func on_mode_selected(mode: String):
	GlobalData.play_sound("click")
	match mode:
		"easy":
			GlobalData.ball_speed = 800
			GlobalData.enemy_speed = 500
			GlobalData.enemy_move_threshold_min = 10.0
			GlobalData.enemy_move_threshold_max = 100.0
			GlobalData.current_game_mode = GlobalData.GameMode.EASY
		"med": 
			GlobalData.ball_speed = 1200
			GlobalData.enemy_speed = 650
			GlobalData.enemy_move_threshold_min = 10.0
			GlobalData.enemy_move_threshold_max = 50.0
			GlobalData.current_game_mode = GlobalData.GameMode.MED
		"hard":
			GlobalData.ball_speed = 1500
			GlobalData.enemy_speed = 800
			GlobalData.enemy_move_threshold_min = 10.0
			GlobalData.enemy_move_threshold_max = 20.0
			GlobalData.current_game_mode = GlobalData.GameMode.HARD
		"prac": 
			GlobalData.ball_speed = 1500
			GlobalData.enemy_speed = 0
			GlobalData.enemy_move_threshold_min = 0 
			GlobalData.enemy_move_threshold_max = 0
			GlobalData.current_game_mode = GlobalData.GameMode.PRAC

	get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")

func on_goal(_scorer: String):
	ball.reset()

func set_all_palettes():
	ui.set_palette()
