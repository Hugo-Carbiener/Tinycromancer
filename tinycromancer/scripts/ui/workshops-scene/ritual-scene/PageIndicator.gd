class_name PageIndicator extends TextureRect

const page_indicator_scene : PackedScene = preload("res://scenes/workshops/ritual/page-indicator.tscn")

@export var selected_page_texture : Texture2D
@export var not_selected_page_texture : Texture2D

static func create_page_indicator() -> PageIndicator:
	var page_indicator = page_indicator_scene.instantiate()
	page_indicator.unselect_page()
	return page_indicator

func select_page():
	texture = selected_page_texture

func unselect_page():
	texture = not_selected_page_texture
