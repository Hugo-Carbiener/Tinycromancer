extends Node

var resources : Dictionary[ResourceManager.Resources, int]
var level_number : int = 1
var troops : Dictionary[TroopFactory.TROOP_TYPES, int] = {
	TroopFactory.TROOP_TYPES.BASE_TROOP : 15,
	TroopFactory.TROOP_TYPES.ARCHER : 2
	}

func _ready() -> void:
	init_resources()

func init_resources():
	for resource in ResourceManager.Resources.values():
		resources.set(resource, 0)
