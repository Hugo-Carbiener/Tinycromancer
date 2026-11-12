extends Node2D

const default_magic_scroll : Texture2D = preload("res://sprites/UI_default-magic-scroll.png")
const blood_magic_scroll : Texture2D = preload("res://sprites/UI_blood-magic-scroll.png")
const dark_magic_scroll : Texture2D = preload("res://sprites/UI_dark-magic-scroll.png")
const unholy_magic_scroll : Texture2D = preload("res://sprites/UI_unholy-magic-scroll.png")

enum MAGIC {
	DEFAULT,
	BLOOD,
	DARK,
	UNHOLY,
}

var scrollPerMagic : Dictionary[MAGIC, Texture2D] = {
	MAGIC.DEFAULT : default_magic_scroll,
	MAGIC.BLOOD : blood_magic_scroll,
	MAGIC.DARK : dark_magic_scroll,
	MAGIC.UNHOLY : unholy_magic_scroll,
}

func get_random_ritual() -> RitualRecipe:
	return null
