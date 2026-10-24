class_name Spawner extends Node2D
 
@export var amount : int
@export_group("Components")
@export var allies_spawn : Node2D
@export var enemies_spawn : Node2D

func prout() -> void:
	for i in range(amount):
		var ally_troop = TroopFactory.create_troop(TroopFactory.TROOPS.BASE_TROOP, CombatManager.FACTIONS.ALLIES)
		var enemy_troop = TroopFactory.create_troop(TroopFactory.TROOPS.BASE_TROOP, CombatManager.FACTIONS.ENEMIES)
		allies_spawn.add_child(ally_troop)
		ally_troop.global_position += Vector2(0, 11 * i)
		enemies_spawn.add_child(enemy_troop)
		enemy_troop.global_position += Vector2(0, 11 * i)
