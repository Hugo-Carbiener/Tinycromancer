class_name CombatManager extends Node2D

enum FACTIONS {
	ALLIES,
	ENEMIES
}

static var instance : CombatManager

var allies : Array[Troop]
var enemies : Array[Troop]
var is_fight_started : bool = false

func _ready() -> void:
	if instance == null:
		instance = self

func get_opponents(faction : FACTIONS) -> Array[Troop]:
	return enemies if faction == FACTIONS.ALLIES else allies

func get_alive_opponents(faction : FACTIONS) -> Array[Troop]:
	var opps = enemies if faction == FACTIONS.ALLIES else allies
	return opps.filter(func(troop): return !troop.is_dead())

func start_fight():
	is_fight_started = true

func _process(delta: float) -> void:
	if !is_fight_started: return
	
	# we make sure all actions are executed before recomputing the targets and states
	execute_troop_actions(delta)
	check_troop_targets()
	check_troop_states()
	

## execute the action of each troop by alternating between teams
func execute_troop_actions(delta: float):
	var max_troop_amount = max(allies.size(), enemies.size())
	for i in range(max_troop_amount):
		if allies.size() > i:
			if allies[i].is_dead(): continue
			
			allies[i].current_state.process(delta)
		if enemies.size() > i:
			if enemies[i].is_dead(): continue

			enemies[i].current_state.process(delta)

func check_troop_targets():
	var max_troop_amount = max(allies.size(), enemies.size())
	for i in range(max_troop_amount):
		if allies.size() > i:
			if allies[i].is_dead(): continue

			allies[i].check_target()
		if enemies.size() > i:
			if enemies[i].is_dead(): continue

			enemies[i].check_target()

func check_troop_states():
	var max_troop_amount = max(allies.size(), enemies.size())
	for i in range(max_troop_amount):
		if allies.size() > i:
			if allies[i].is_dead(): continue

			allies[i].check_state()
		if enemies.size() > i:
			if enemies[i].is_dead(): continue

			enemies[i].check_state()
