extends Node

var resources : Dictionary[ResourceManager.Resources, int]
var level_number : int = 1
var troops : Dictionary[TroopFactory.TROOP_TYPES, int] = {
	TroopFactory.TROOP_TYPES.BASE_TROOP : 15,
	TroopFactory.TROOP_TYPES.GUNNER : 2
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
