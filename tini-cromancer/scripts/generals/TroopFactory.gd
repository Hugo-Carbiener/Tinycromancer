extends Node2D

var base_troop_scene : PackedScene = preload("res://scenes/combat.tscn")

enum TROOPS {
	BASE_TROOP
}

var troop_scenes_by_id : Dictionary[TROOPS, PackedScene] = {
	TROOPS.BASE_TROOP: base_troop_scene
}

func create_troop(troop_id : TROOPS, faction : CombatManager.FACTIONS) -> Troop:
	var troop = troop_scenes_by_id[troop_id].instantiate()
	troop.setup()
	troop.faction = faction
	return troop
