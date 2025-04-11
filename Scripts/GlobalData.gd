extends Node

var enemy_move_threshold_min: float
var enemy_move_threshold_max: float
var enemy_speed: float = 500
var is_paused: bool = false

# Audio
var base_music_level: float = -15.0
var music_level_modifier: float = 0.0
var music_player: AudioStreamPlayer
var music: AudioStream = preload("res://Audio/Sketchbook 2024-11-30.ogg")

var base_master_level: float = -11.0
var master_level_modifier: float = 0.0
var master_player: AudioStreamPlayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS 

	music_player = AudioStreamPlayer.new()
	music_player.stream = music
	music_player.volume_db = base_music_level
	music_player.finished.connect(on_music_end)
	add_child(music_player)
	music_player.play()

	master_player = AudioStreamPlayer.new()
	master_player.volume_db = base_master_level
	add_child(master_player)

var palettes: Dictionary = {
	"Default": {"object": "#ffffff", "background": "#000000"},
	"Inverted": {"object": "#000000", "background": "#ffffff"},
	"Cool Grape": {"object": "#4C2394", "background": "#D3BBFC"},
	"Creamy Matcha": {"object": "#41512B", "background": "#DAEDBE"},
	"Marvelous Blueberry": {"object": "#01258f", "background": "#Cbd9fe"},
	"Grass and sky": {"object": "#0073c5", "background": "#a4daae"},
	"Maple Candy": {"object": "#fae8d6", "background": "#a02800"},
	"Morning coffee": {"object": "#fff9ea", "background": "#533b2a"},
	"Pumpkin realness": {"object": "#692f02", "background": "#db8340"},
	"Cranberry dream": {"object": "#debfc7", "background": "#a60029"},
	"Castle Knight": {"object": "#4f4f4f", "background": "#bfbfbf"},
	"Mermaid hideaway": {"object": "#018b59", "background": "#Cbfefc"},
	"Midnight rain": {"object": "#c0c9d7", "background": "#002a54"},
	"Pigeon inspired": {"object": "#8cbdc3", "background": "#3c3f44"},
}

var active_palette_key = "Default"
var active_palette: Dictionary = palettes[active_palette_key]

# Audio
var sounds: Dictionary[String, AudioStream] = {
	"click": preload("res://Audio/click5.ogg"),
	"bounce": preload("res://Audio/tone1.ogg"),
	"player_scored": preload("res://Audio/powerUp2.ogg"),
	"enemy_scored": preload("res://Audio/powerUp10.ogg"),
}
func on_music_end():
	music_player.play()

func set_music_level(new_modifer) -> void:
	if music_player.volume_db != -10000:
		music_level_modifier = (100 - new_modifer) * .01
		if music_level_modifier == 1.0:
			music_player.volume_db = -10000
		else:
			music_player.volume_db = base_music_level + (base_music_level * music_level_modifier)

func set_master_level(new_modifer) -> void:
	print("Set master level")
	master_level_modifier = (100 - new_modifer) * .01
	print(master_level_modifier)
	if master_level_modifier == 1.0:
		master_player.volume_db = -10000
		music_player.volume_db = - 10000
	else:
		master_player.volume_db = base_master_level + (base_master_level * master_level_modifier)
		music_player.volume_db = base_music_level + (base_music_level * master_level_modifier)

func play_sound(sound_name: String) -> void:
	if sound_name in sounds:
		master_player.stream = sounds[sound_name]
		master_player.play()
	else:
		push_error("Invalid sound name '", sound_name, "'")
	pass
