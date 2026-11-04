class_name Tab extends Button

const tab_scene : PackedScene = preload("res://scenes/ui/tab_button.tscn")

@export_group("Tab customization")
@export var icon_texture : Texture2D
@export var title : String
@export var signal_to_emit : String

var toggled_via_code = false

func _ready() -> void:
	icon.texture = icon_texture
	text = title
	toggled.connect(on_toggle)

func on_toggle(on : bool):
	if on:
		if SignalBus.has_signal(signal_to_emit): 
			SignalBus.emit_signal(signal_to_emit, self)
		else:
				printerr("Signal " + signal_to_emit + " on tab is not defined.")
	elif not toggled_via_code: 
		button_pressed = true

func unselect():
	toggled_via_code = true
	button_pressed = false
	toggled_via_code = false
