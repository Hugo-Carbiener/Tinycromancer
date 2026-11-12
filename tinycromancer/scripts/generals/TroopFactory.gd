extends Node2D

var base_troop_scene : PackedScene = preload("res://scenes/actors/troop.tscn")
var archer_troop_scene : PackedScene = preload("res://scenes/actors/troop_archer.tscn")
var enemy_base_troop_scene : PackedScene = preload("res://scenes/actors/troop_enemy.tscn")

enum TROOP_TYPES {
	BASE_TROOP,
	ARCHER,
	ENEMY_BASE_TROOP
	}

var troop_scenes_by_id : Dictionary[TROOP_TYPES, PackedScene] = {
	TROOP_TYPES.BASE_TROOP: base_troop_scene,
	TROOP_TYPES.ARCHER: archer_troop_scene,
	TROOP_TYPES.ENEMY_BASE_TROOP: enemy_base_troop_scene
}

func create_troop(troop_id : TROOP_TYPES, faction : CombatManager.FACTIONS) -> Troop:
	var troop : Troop = troop_scenes_by_id[troop_id].instantiate()
	troop.faction = faction
	CombatManager.instance.register_troop(troop)
	return troop
