class_name ScoreUI
extends Control

@onready var player_score: Label = $MarginContainer/HBoxContainer/PlayerScore
@onready var enemy_score: Label = $MarginContainer/HBoxContainer/EnemyScore

func _ready():
	set_palette()

func set_palette() -> void:
	# Set color and alpha values
	player_score.self_modulate = GlobalData.active_palette["object"]
	player_score.self_modulate.a = .25
	enemy_score.self_modulate = GlobalData.active_palette["object"]
	enemy_score.self_modulate.a = .25