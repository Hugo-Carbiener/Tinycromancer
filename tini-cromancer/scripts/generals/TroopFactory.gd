extends Node2D

var base_troop_scene : PackedScene = preload("res://scenes/components/troop.tscn")
var archer_troop_scene : PackedScene = preload("res://scenes/components/troop_archer.tscn")
var enemy_base_troop_scene : PackedScene = preload("res://scenes/components/troop_enemy.tscn")

enum TROOPS {
	BASE_TROOP,
	ARCHER,
	ENEMY_BASE_TROOP
	}




var troop_scenes_by_id : Dictionary[TROOPS, PackedScene] = {
	TROOPS.BASE_TROOP: base_troop_scene,
	TROOPS.ARCHER: archer_troop_scene,
	TROOPS.ENEMY_BASE_TROOP: enemy_base_troop_scene
}

func create_troop(troop_id : TROOPS, faction : CombatManager.FACTIONS) -> Troop:
	var troop : Troop = troop_scenes_by_id[troop_id].instantiate()
	troop.faction = faction
	CombatManager.instance.register_troop(troop)
	return troop
