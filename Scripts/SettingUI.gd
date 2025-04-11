class_name SettingUi
extends Control

@onready var title_card: RichTextLabel = $MarginContainer/TitleCard

@onready var music_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/MusicLabel
@onready var music_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer/MusicSlider
@onready var music_level: Label = $MarginContainer/VBoxContainer/HBoxContainer/MusicLevel

@onready var master_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/MasterLabel
@onready var master_slider: HSlider = $MarginContainer/VBoxContainer/HBoxContainer2/MasterSlider
@onready var master_level: Label = $MarginContainer/VBoxContainer/HBoxContainer2/MasterLevel

@onready var palette_label: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PaletteLabel
@onready var palette_options: OptionButton = $MarginContainer/VBoxContainer/HBoxContainer3/PaletteOptionButton

var main
signal palette_changed

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	# Add palette names to palettes options button
	for key in GlobalData.palettes:
		palette_options.add_item(key)
	palette_options.select(0)
	
	# Connect to signals
	palette_options.item_selected.connect(on_palette_selected)
	palette_options.pressed.connect(on_palette_options_pressed)

	music_slider.drag_ended.connect(on_music_level_set)
	master_slider.drag_ended.connect(on_master_level_set)

	set_palette()

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		if GlobalData.is_paused:
			main.pause_game()
			accept_event() # Prevent input in main from continuing to process this input

func set_palette():
	title_card.modulate = GlobalData.active_palette["object"]
	music_label.modulate = GlobalData.active_palette["object"]
	music_slider.modulate = GlobalData.active_palette["object"]
	music_level.modulate = GlobalData.active_palette["object"]
	master_label.modulate = GlobalData.active_palette["object"]
	master_slider.modulate = GlobalData.active_palette["object"]
	master_level.modulate = GlobalData.active_palette["object"]
	palette_label.modulate = GlobalData.active_palette["object"]
	palette_options.modulate = GlobalData.active_palette["object"]

	var popup: PopupMenu = palette_options.get_popup()
	var item_stylebox = StyleBoxFlat.new()
	item_stylebox.bg_color = GlobalData.active_palette["object"]
	popup.add_theme_color_override("font", GlobalData.active_palette["object"])
	popup.add_theme_font_size_override("font_size", 35)
	popup.add_theme_stylebox_override("panel", item_stylebox)

func on_palette_selected(index) -> void:
	GlobalData.play_sound("click")
	palette_changed.emit(palette_options.get_item_text(index))

func on_palette_options_pressed() -> void:
	GlobalData.play_sound("click")

func on_music_level_set(value_changed: bool):
	if value_changed:
		music_level.text = str(int(music_slider.value))
		GlobalData.set_music_level(music_slider.value)

func on_master_level_set(value_changed: bool):
	if value_changed:
		master_level.text = str(int(master_slider.value))
		GlobalData.set_master_level(master_slider.value)