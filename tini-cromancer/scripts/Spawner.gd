class_name Spawner extends Node2D
 
@export var ally_troops : Dictionary[TroopFactory.TROOPS, int]
@export var ennemy_troops : Dictionary[TroopFactory.TROOPS, int]
@export_group("Components")
@export var allies_spawn : Node2D
@export var enemies_spawn : Node2D

var furthest_troop : Troop
var vertical_offset_spawn_position : float
var step : int = 11
var max_troop_by_row : int = 20
var current_troop_by_row

func spawn_troops():
	spawn_troops_from_faction(CombatManager.FACTIONS.ALLIES)
	spawn_troops_from_faction(CombatManager.FACTIONS.ENEMIES)

func reset_vertical_offset_spawn_position(number_troops_of_type : int):
	if number_troops_of_type%2 == 0:
		vertical_offset_spawn_position = -1 * step/2.
	else:
		vertical_offset_spawn_position = 0

func update_vertical_offset_spawn_position():
	if vertical_offset_spawn_position >= 0:
		vertical_offset_spawn_position += step
	vertical_offset_spawn_position *= -1

func determine_spawn_troop_position(troop : Troop, number_troops_of_type : int):
	if furthest_troop == null:
		furthest_troop = troop
		reset_vertical_offset_spawn_position(number_troops_of_type)
		
		troop.global_position = Vector2(furthest_troop.global_position.x,(troop.global_position.y + vertical_offset_spawn_position))
		update_vertical_offset_spawn_position()
	else:
	
		if troop.movement_module.cowardice != furthest_troop.movement_module.cowardice || current_troop_by_row >= max_troop_by_row:
			reset_vertical_offset_spawn_position(number_troops_of_type)
			troop.global_position = Vector2((furthest_troop.global_position.x - step),(troop.global_position.y + vertical_offset_spawn_position))
			furthest_troop = troop
			update_vertical_offset_spawn_position()
			current_troop_by_row = 0
		
		else :
			troop.global_position = Vector2(furthest_troop.global_position.x,(troop.global_position.y + vertical_offset_spawn_position))
			update_vertical_offset_spawn_position()

func spawn_troops_from_faction(faction : CombatManager.FACTIONS):
	var troops = {}
	var spawn = null
	furthest_troop = null
	current_troop_by_row = 0
	
	match(faction):
		CombatManager.FACTIONS.ALLIES:
			troops = ally_troops
			spawn = allies_spawn
		CombatManager.FACTIONS.ENEMIES:
			troops = ennemy_troops
			spawn = enemies_spawn
	
	for troop_type in troops.keys():
		var number_troops_of_type = troops[troop_type]
		for i in range(number_troops_of_type):
			var new_troop = TroopFactory.create_troop(troop_type, faction)
			new_troop.global_position = spawn.global_position
			determine_spawn_troop_position(new_troop, number_troops_of_type)
			current_troop_by_row += 1
			spawn.add_child(new_troop)
