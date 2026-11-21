extends Node2D

const base_soul_icon : Texture2D = preload("res://sprites/UI_currency-icon.png")

enum Resources {
	BASIC_SOUL,
}

var resource_icons = {
	Resources.BASIC_SOUL : base_soul_icon
}
