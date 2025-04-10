class_name PauseUI
extends Control

@onready var buttons: VBoxContainer = $MarginContainer/VBoxContainer2/ButtonsVbox
@onready var button_1: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button1
@onready var button_2: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button2
@onready var button_3: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button3
var main

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	# Connect to button signals
	for b: TextureButton in buttons.get_children():
		b.mouse_entered.connect(on_button_entered.bind(b))
		b.mouse_exited.connect(on_button_exited.bind(b))
		b.pressed.connect(on_button_pressed.bind(b))

	buttons.z_index = 999

func on_button_entered(button: TextureButton):
	var label: RichTextLabel = button.get_node("Label")
	label.bbcode_enabled = true # Maybe just do once for all ?
	label.text = label.get_parsed_text()
	label.text = "[color=#000009]" + label.text

func on_button_exited(button: TextureButton):
	var label: RichTextLabel = button.get_node("Label")
	label.text = label.get_parsed_text()
	label.text = "[color=white]" + label.text

func on_button_pressed(button: TextureButton):
	GlobalData.click_player.play()
	match button:
		button_1:
			main.unpause_game()
		button_2:
			pass
		button_3:
			main.go_to_title_menu()

func _input(_event):
	if Input.is_action_just_pressed("pause"):
		if GlobalData.is_paused:
			main.unpause_game()
			accept_event() # Prevent input in main from continuing to process this input
