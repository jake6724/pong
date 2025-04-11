extends Node2D

@onready var ball: Ball = $Ball
@onready var enemy_paddle = $EnemyPaddle
@onready var player_paddle = $PlayerPaddle
@onready var arena = $Arena
@onready var player_score: Label = $CanvasLayer/ScoreUI/MarginContainer/HBoxContainer/PlayerScore
@onready var enemy_score: Label = $CanvasLayer/ScoreUI/MarginContainer/HBoxContainer/EnemyScore
@onready var pause_ui: Control = $CanvasLayer/PauseUI
@onready var settings_ui: Control = $CanvasLayer/SettingUI
var max_goals: int = 7
var audio_player: AudioStreamPlayer
var click: AudioStream = preload("res://Audio/switch2.ogg")

func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE 
	enemy_paddle.ball = ball
	arena.player_point.connect(on_goal)
	arena.enemy_point.connect(on_goal)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	# Configure UI's
	pause_ui.main = self
	settings_ui.main = self

	# # Configure audio
	# audio_player.stream = click
	# add_child(audio_player)

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
		go_to_title_menu()

func _input(_event):
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://Scenes/main.tscn")

	if Input.is_action_just_pressed("pause"):
		if not GlobalData.is_paused:
			pause_game()

func pause_game():
	settings_ui.visible = false
	arena.center_line.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pause_ui.visible = true
	get_tree().paused = true
	GlobalData.is_paused = true

func unpause_game():
	get_tree().paused = false

	arena.center_line.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pause_ui.visible = false
	GlobalData.is_paused = false

func go_to_title_menu():
	unpause_game()
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/title_screen.tscn")

func show_settings():
	settings_ui.visible = true
	pause_ui.visible = false

func set_all_palettes():
	pass
