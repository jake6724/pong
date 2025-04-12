class_name TitleScreenUI
extends Control

# Child references
@onready var title_card: RichTextLabel = $MarginContainer/VBoxContainer2/TitleCard

@onready var buttons: VBoxContainer = $MarginContainer/VBoxContainer2/ButtonsVbox
@onready var button_1: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button1
@onready var button_2: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button2
@onready var button_3: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button3
@onready var button_4: TextureButton = $MarginContainer/VBoxContainer2/ButtonsVbox/Button4

@onready var button_1_label: RichTextLabel = $MarginContainer/VBoxContainer2/ButtonsVbox/Button1/Label
@onready var button_2_label: RichTextLabel = $MarginContainer/VBoxContainer2/ButtonsVbox/Button2/Label
@onready var button_3_label: RichTextLabel = $MarginContainer/VBoxContainer2/ButtonsVbox/Button3/Label
@onready var button_4_label: RichTextLabel = $MarginContainer/VBoxContainer2/ButtonsVbox/Button4/Label

@onready var mode_desc: RichTextLabel = $MarginContainer/VBoxContainer2/ModeDesc

var easy_desc: String = "Slowest ball speed, unskilled opponent."
var med_desc: String = "Moderate ball speed, moderately skilled opponent."
var hard_desc: String = "Fastest ball speed, skilled opponent."
var prac_desc: String = "Practice mode. Fastest ball speed, your opponent will never miss!"

signal mode_selected

func _ready():
	# Connect to button signals
	for b: TextureButton in buttons.get_children():
		b.mouse_entered.connect(on_button_entered.bind(b))
		b.mouse_exited.connect(on_button_exited.bind(b))
		b.pressed.connect(on_button_pressed.bind(b))
		
	buttons.z_index = 999
	mode_desc.text = "No audio until you click the screen!"

	set_palette()

func on_button_entered(button: TextureButton):
	var label: RichTextLabel = button.get_node("Label")
	label.bbcode_enabled = true # Maybe just do once for all ?
	label.text = label.get_parsed_text()
	label.text = "[color=" + str(GlobalData.active_palette["background"]) + "]" + label.text

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
	var label: RichTextLabel = button.get_node("Label")
	label.text = label.get_parsed_text()
	label.text = "[color=" + str(GlobalData.active_palette["object"]) + "]" + label.text
	mode_desc.text = ""

func on_button_pressed(button: TextureButton):
	match button:
		button_1:
			mode_selected.emit("easy")
		button_2:
			mode_selected.emit("med")
		button_3:
			mode_selected.emit("hard")
		button_4:
			mode_selected.emit("prac")
	
func set_palette():
	title_card.self_modulate = GlobalData.active_palette["object"]
	button_1.self_modulate = GlobalData.active_palette["object"]
	button_2.self_modulate = GlobalData.active_palette["object"]
	button_3.self_modulate = GlobalData.active_palette["object"]
	button_4.self_modulate = GlobalData.active_palette["object"]
	mode_desc.self_modulate = GlobalData.active_palette["object"]

	# Modulate would override the BBC tags that are use in `on_button_entered`; this does not.
	button_1_label.add_theme_color_override("default_color", GlobalData.active_palette["object"])
	button_2_label.add_theme_color_override("default_color", GlobalData.active_palette["object"])
	button_3_label.add_theme_color_override("default_color", GlobalData.active_palette["object"])
	button_4_label.add_theme_color_override("default_color", GlobalData.active_palette["object"])
