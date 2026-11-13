extends Node

var resources : Dictionary[ResourceManager.Resources, int]
var level_number : int = 1
var troops : Dictionary[Array, int] = {
	[TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.DEFAULT] : 15,
	[TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.DEFAULT] : 5,
}
var ritual_recipes : Array[RitualRecipe] = [
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.DEFAULT, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.BLOOD, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.DARK, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.UNHOLY, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.BLOOD, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.DEFAULT, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.DARK, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.UNHOLY, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.BLOOD, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.DARK, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.BASE_TROOP, RitualFactory.MAGIC.UNHOLY, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.BLOOD, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.DARK, {}, 1),
	RitualRecipe.create_ritual(TroopFactory.TROOP_TYPES.GUNNER, RitualFactory.MAGIC.UNHOLY, {}, 1),
]

func _ready() -> void:
	init_resources()

func init_resources():
	for resource in ResourceManager.Resources.values():
		resources.set(resource, 0)

func get_troops_without_magic() -> Dictionary[TroopFactory.TROOP_TYPES, int]:
	var res : Dictionary[TroopFactory.TROOP_TYPES, int]
	for key in troops.keys():
		res.set(key[0], res.get_or_add(key[0], 0) + troops[key])
	return res
