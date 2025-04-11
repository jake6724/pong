extends Node

var enemy_move_threshold_min: float
var enemy_move_threshold_max: float
var enemy_speed: float = 500
var music_player: AudioStreamPlayer
var music: AudioStream = preload("res://Audio/Sketchbook 2024-11-30.ogg")
var click_player: AudioStreamPlayer
var click: AudioStream = preload("res://Audio/click5.ogg")
var is_paused: bool = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS 

	music_player = AudioStreamPlayer.new()
	music_player.stream = music
	music_player.volume_db = -15
	music_player.finished.connect(on_music_end)
	add_child(music_player)
	#music_player.play()

	click_player = AudioStreamPlayer.new()
	click_player.stream = click
	click_player.volume_db = -7
	add_child(click_player)

func on_music_end():
	music_player.play()

var palettes: Dictionary = {
	"Default": {"object": Color.WHITE, "background": Color.BLACK},
	"red": {"object": Color.BLACK, "background": Color.WHITE},
	"blue": {"object": Color.BLACK, "background": Color.WHITE},
	"Green": {"object": Color.GREEN, "background": Color.WHITE},
	"Cool Grape": {"object": "#4C2394", "background": "#D3BBFC"},
	"Creamy Matcha": {"object": "#41512B", "background": "#DAEDBE"},
	"Marvelous Blueberry": {"object": "#4C2394", "background": "#D3BBFC"},
	"Grass and sky": {"object": "#4C2394", "background": "#D3BBFC"},
	"Maple Candy": {"object": "#4C2394", "background": "#D3BBFC"},
	"Morning coffee": {"object": "#4C2394", "background": "#D3BBFC"},
	"Pumpkin realness": {"object": "#4C2394", "background": "#D3BBFC"},
	"Cranberry dream": {"object": "#4C2394", "background": "#D3BBFC"},
	"Castle Knight": {"object": "#4C2394", "background": "#D3BBFC"},
	"Love in the air": {"object": "#4C2394", "background": "#D3BBFC"},
	"Mermaid hideaway": {"object": "#4C2394", "background": "#D3BBFC"},
	"Midnight rain": {"object": "#4C2394", "background": "#D3BBFC"},
	"Pigeon inspired": {"object": "#4C2394", "background": "#D3BBFC"},
}

var active_palette_key = "Creamy Matcha"
var active_palette: Dictionary = palettes[active_palette_key]
