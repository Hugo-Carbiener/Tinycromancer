extends Node2D

enum MAGIC {
	DEFAULT,
	BLOOD,
	DARK,
	UNHOLY,
}

var magicNames : Dictionary[MAGIC, String] = {
	MAGIC.DEFAULT : "Base magic",
	MAGIC.BLOOD : "Blood magic",
	MAGIC.DARK : "Dark magic",
	MAGIC.UNHOLY : "Unholy magic",
}

var scrollPerMagic : Dictionary[MAGIC, Texture2D] = {
	MAGIC.DEFAULT : preload("res://sprites/UI_default-magic-scroll.png"),
	MAGIC.BLOOD : preload("res://sprites/UI_blood-magic-scroll.png"),
	MAGIC.DARK : preload("res://sprites/UI_dark-magic-scroll.png"),
	MAGIC.UNHOLY : preload("res://sprites/UI_unholy-magic-scroll.png"),
}

var icons : Dictionary[MAGIC, Texture2D] = {
	MAGIC.DEFAULT : preload("res://sprites/UI_base-magic-icon.png"),
	MAGIC.BLOOD : preload("res://sprites/UI_blood-magic-icon.png"),
	MAGIC.DARK : preload("res://sprites/UI_dark-magic-icon.png"),
	MAGIC.UNHOLY : preload("res://sprites/UI_unholy-magic-icon.png"),
}

func get_random_ritual() -> RitualRecipe:
	return null
