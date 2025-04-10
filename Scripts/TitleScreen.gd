extends Node2D

@onready var ball: Ball = $Ball
@onready var enemy_paddle = $EnemyPaddle
@onready var enemy_paddle_2 = $EnemyPaddle2
@onready var arena = $Arena
@onready var ui = $TitleScreenUI
var audio_player: AudioStreamPlayer
var click: AudioStream = preload("res://Audio/switch2.ogg")

var max_goals: int = 7

func _ready():
	enemy_paddle.ball = ball
	enemy_paddle_2.ball = ball
	arena.player_point.connect(on_goal)
	arena.enemy_point.connect(on_goal)

	arena.center_line.visible = false

	ui.mode_selected.connect(on_mode_selected)

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Configure audio
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = click
	add_child(audio_player)

func on_mode_selected(mode: String):
	GlobalData.click_player.play()
	match mode:
		"easy":
			GlobalData.enemy_speed = 500
			GlobalData.enemy_move_threshold_min = 10.0
			GlobalData.enemy_move_threshold_max = 100.0
		"med": 
			GlobalData.enemy_speed = 500
			GlobalData.enemy_move_threshold_min = 10.0
			GlobalData.enemy_move_threshold_max = 100.0
		"hard":
			GlobalData.enemy_speed = 500
			GlobalData.enemy_move_threshold_min = 10.0
			GlobalData.enemy_move_threshold_max = 100.0
		"prac": 
			GlobalData.enemy_speed = 500
			GlobalData.enemy_move_threshold_min = 10.0
			GlobalData.enemy_move_threshold_max = 100.0

	get_tree().call_deferred("change_scene_to_file", "res://Scenes/main.tscn")


func on_goal(_scorer: String):
	ball.reset()
