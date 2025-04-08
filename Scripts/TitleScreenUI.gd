class_name TitleScreenUI
extends Control

@onready var buttons: VBoxContainer = $MarginContainer/VBoxContainer2/ButtonsVbox
@onready var button_1: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button1
@onready var button_2: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button2
@onready var button_3: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button3
@onready var button_4: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button4

func _ready():
	# Connect to button signals
	for b: TextureButton in buttons.get_children():
		print(b)
		b.mouse_entered.connect(on_button_entered.bind(b))
		b.mouse_exited.connect(on_button_exited.bind(b))

func on_button_entered(button: TextureButton):
	var label: RichTextLabel = button.get_node("Label")
	label.bbcode_enabled = true # Maybe just do once for all ?
	var plain_text: String = label.text
	label.text = "[color=#000009]" + label.text

func on_button_exited(button: TextureButton):
	print("test")
	var label: RichTextLabel = button.get_node("Label")
	print(label)
	var plain_text: String = label.text
	label.text = "[color=white] Test [/color]" 

	
