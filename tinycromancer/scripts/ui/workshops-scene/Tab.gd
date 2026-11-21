class_name Tab extends Control

const tab_scene : PackedScene = preload("res://scenes/ui-components/tab_button.tscn")

@export_group("Components")
@export var button : Button
@export var icon_sprite : TextureRect
@export var title_label : Label
var tab_destination : WorkshopManager.WORKSHOPS

var toggled_via_code = false

static func create_tab(tabData : TabData) -> Tab:
	var tab = tab_scene.instantiate()
	tab.setup(tabData)
	return tab

func setup(tabData : TabData):
	icon_sprite.texture = tabData.icon_texture
	title_label.text = tabData.tab_title
	tab_destination = tabData.destination_workshop
	button.toggled.connect(on_toggle)
	unselect()

func on_toggle(on : bool):
	if on:
		SignalBus.tab_clicked.emit(self)
		select()
	elif not toggled_via_code: 
		button.button_pressed = true

func select():
	icon_sprite.self_modulate = Color.WHITE
	title_label.self_modulate = Color.WHITE
	
func unselect():
	toggled_via_code = true
	button.button_pressed = false
	icon_sprite.self_modulate = Color.DIM_GRAY
	title_label.self_modulate = Color.DIM_GRAY
	toggled_via_code = false
