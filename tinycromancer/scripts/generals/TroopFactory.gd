extends Node2D

var base_troop_scene : PackedScene = preload("res://scenes/actors/troop.tscn")
var gunner_troop_scene : PackedScene = preload("res://scenes/actors/troop_gunner.tscn")
var enemy_base_troop_scene : PackedScene = preload("res://scenes/actors/troop_enemy.tscn")

var base_troop_icon : Texture2D = preload("res://sprites/UI_troop-base-icon.png")
var gunner_icon : Texture2D = preload("res://sprites/UI_troop-gunner-icon.png")
var enemy_base_troop_icon : Texture2D = preload("res://sprites/UI_enemy-troop-base-icon.png")

enum TROOP_TYPES {
	BASE_TROOP,
	GUNNER,
	ENEMY_BASE_TROOP,
	}

var troop_icons : Dictionary[TROOP_TYPES, Texture2D] = {
	TROOP_TYPES.BASE_TROOP : base_troop_icon,
	TROOP_TYPES.GUNNER : gunner_icon,
	TROOP_TYPES.ENEMY_BASE_TROOP : enemy_base_troop_icon
}

var troop_scenes_by_id : Dictionary[TROOP_TYPES, PackedScene] = {
	TROOP_TYPES.BASE_TROOP: base_troop_scene,
	TROOP_TYPES.GUNNER: gunner_troop_scene,
	TROOP_TYPES.ENEMY_BASE_TROOP : enemy_base_troop_scene,
}

func create_troop(troop_id : TROOP_TYPES, faction : CombatManager.FACTIONS, _magic : RitualFactory.MAGIC = RitualFactory.MAGIC.DEFAULT) -> Troop:
	var troop : Troop = troop_scenes_by_id[troop_id].instantiate()
	troop.faction = faction
	troop.magic = _magic
	CombatManager.instance.register_troop(troop)
	return troop
