class_name RitualRecipe extends Control

const ritual_scene : PackedScene = preload("res://scenes/ui-components/ritual_recipe.tscn")

@export_group("Components")
@export var background_texture : TextureRect
@export var outline_texture : TextureRect
@export var troop_texture : TextureRect

var troop_type : TroopFactory.TROOP_TYPES
var magic_type : RitualFactory.MAGIC
var resource_cost : Dictionary[ResourceManager.Resources, int]
var uses_left : int
var max_uses : int

static func create_ritual(_troop_type : TroopFactory.TROOP_TYPES, _magic_type : RitualFactory.MAGIC, _resource_cost : Dictionary[ResourceManager.Resources, int], uses : int) -> RitualRecipe:
	var ritual = ritual_scene.instantiate()
	ritual.setup(_troop_type, _magic_type, _resource_cost, uses)
	return ritual

func setup(_troop_type : TroopFactory.TROOP_TYPES, _magic_type : RitualFactory.MAGIC, _resource_cost : Dictionary[ResourceManager.Resources, int], uses : int):
	troop_type = _troop_type
	magic_type = _magic_type
	resource_cost = _resource_cost
	max_uses = uses
	uses_left = uses
	init_signals()
	init_sprites()

func init_signals():
	mouse_entered.connect(on_mouse_enter)
	mouse_exited.connect(on_mouse_exit)

func init_sprites():
	background_texture.texture = RitualFactory.scrollPerMagic[magic_type]
	troop_texture.texture = TroopFactory.troop_icons[troop_type]

func on_mouse_enter():
	outline_texture.visible = true

func on_mouse_exit():
	outline_texture.visible = false
