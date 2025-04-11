class_name PauseUI
extends Control

@onready var title_card: RichTextLabel = $MarginContainer/VBoxContainer2/TitleCard

@onready var buttons: VBoxContainer = $MarginContainer/VBoxContainer2/ButtonsVbox
@onready var button_1: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button1
@onready var button_2: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button2
@onready var button_3: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button3

@onready var button_1_label: RichTextLabel = $MarginContainer/VBoxContainer2/ButtonsVbox/Button1/Label
@onready var button_2_label: RichTextLabel = $MarginContainer/VBoxContainer2/ButtonsVbox/Button2/Label
@onready var button_3_label: RichTextLabel = $MarginContainer/VBoxContainer2/ButtonsVbox/Button3/Label

var main

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	# Connect to button signals, configure labels
	for b: TextureButton in buttons.get_children():
		b.mouse_entered.connect(on_button_entered.bind(b))
		b.mouse_exited.connect(on_button_exited.bind(b))
		b.pressed.connect(on_button_pressed.bind(b))
		var b_label = b.get_node("Label")
		b_label.bbcode_enabled = true

	buttons.z_index = 999
	set_palette()

func on_button_entered(button: TextureButton):
	var label: RichTextLabel = button.get_node("Label")
	label.text = label.get_parsed_text()
	label.text = "[color=" + str(GlobalData.active_palette["background"]) + "]" + label.text

func on_button_exited(button: TextureButton):
	var label: RichTextLabel = button.get_node("Label")
	label.text = label.get_parsed_text()
	label.text = "[color=" + str(GlobalData.active_palette["object"]) + "]" + label.text

func on_button_pressed(button: TextureButton):
	GlobalData.play_sound("click")
	match button:
		button_1:
			main.unpause_game()
		button_2:
			main.show_settings()
		button_3:
			main.go_to_title_menu()

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		if GlobalData.is_paused:
			main.unpause_game()
			accept_event() # Prevent input in main from continuing to process this input

func set_palette():
	title_card.self_modulate = GlobalData.active_palette["object"]
	button_1.self_modulate = GlobalData.active_palette["object"]
	button_2.self_modulate = GlobalData.active_palette["object"]
	button_3.self_modulate = GlobalData.active_palette["object"]

	# Modulate would override the BBC tags that are use in `on_button_entered`; this does not.
	button_1_label.text = button_1_label.get_parsed_text()
	button_2_label.text = button_2_label.get_parsed_text()
	button_3_label.text = button_3_label.get_parsed_text()
	button_1_label.add_theme_color_override("default_color", GlobalData.active_palette["object"])
	button_2_label.add_theme_color_override("default_color", GlobalData.active_palette["object"])
	button_3_label.add_theme_color_override("default_color", GlobalData.active_palette["object"])
