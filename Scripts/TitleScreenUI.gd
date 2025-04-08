class_name TitleScreenUI
extends Control

@onready var buttons: VBoxContainer = $MarginContainer/VBoxContainer2/ButtonsVbox
@onready var button_1: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button1
@onready var button_2: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button2
@onready var button_3: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button3
@onready var button_4: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button4
@onready var background: ColorRect = $Background
@onready var mode_desc: RichTextLabel = $MarginContainer/VBoxContainer2/ModeDesc

var easy_desc: String = "Best for beginners. The computer opponent will have a hard time keeping up!"
var med_desc: String = "Best for intermediate. The computer opponent will put up a fight!"
var hard_desc: String = "Best for experienced players. The computer opponent will NOT let you win easily!"
var prac_desc: String = "Practice mode. The computer opponent will never miss!"

func _ready():
	# Connect to button signals
	for b: TextureButton in buttons.get_children():
		print(b)
		b.mouse_entered.connect(on_button_entered.bind(b))
		b.mouse_exited.connect(on_button_exited.bind(b))
		b.pressed.connect(on_button_pressed.bind(b))

	background.z_index = -999
	buttons.z_index = 999

func on_button_entered(button: TextureButton):
	var label: RichTextLabel = button.get_node("Label")
	label.bbcode_enabled = true # Maybe just do once for all ?
	label.text = label.get_parsed_text()
	label.text = "[color=#000009]" + label.text

	match button:
		button_1:
			mode_desc.text = easy_desc
		button_2:
			mode_desc.text = med_desc
		button_3:
			mode_desc.text = hard_desc
		button_4:
			mode_desc.text = prac_desc

func on_button_exited(button: TextureButton):
	print("test")
	var label: RichTextLabel = button.get_node("Label")
	print(label)
	label.text = label.get_parsed_text()
	label.text = "[color=white]" + label.text
	
	mode_desc.text = ""

func on_button_pressed(button: TextureButton):
	pass

# Add a palette option
	
