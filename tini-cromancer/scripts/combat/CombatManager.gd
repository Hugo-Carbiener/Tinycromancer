class_name CombatManager extends Node2D

enum FACTIONS {
	ALLIES,
	ENEMIES
}

static var instance : CombatManager

@export var spawner : Spawner
var allies : Array[Troop]
var alive_allies : Array[Troop]
var enemies : Array[Troop]
var alive_enemies : Array[Troop]
var is_fight_started : bool = false
var shot_id : int = 0

func _ready() -> void:
	if instance == null:
		instance = self
	build_level()

func build_level():
	spend_rest_currency()
	spawner.ally_troops = UserData.troops
	spawner.enemy_troops = set_enemy_troops()
	
func spend_rest_currency():
	if UserData.souls > 0:
		if not UserData.troops.has(TroopFactory.ROLES.BASE_TROOP):
			UserData.troops[TroopFactory.ROLES.BASE_TROOP] = UserData.souls
		else:
			UserData.troops[TroopFactory.ROLES.BASE_TROOP] += UserData.souls
	UserData.souls = 0
		
func set_enemy_troops():
	#TODO : améliorer avec les nouvelles troop
	var enemy_troops : Dictionary[TroopFactory.ROLES, int] = {TroopFactory.ROLES.ENEMY_BASE_TROOP : UserData.level_number * 10}
	return enemy_troops

func register_troop(troop : Troop):
	match (troop.faction):
		FACTIONS.ALLIES: 
			allies.append(troop)
			alive_allies.append(troop)
		FACTIONS.ENEMIES: 
			enemies.append(troop)
			alive_enemies.append(troop)

func get_opponents(faction : FACTIONS) -> Array[Troop]:
	return enemies if faction == FACTIONS.ALLIES else allies

func get_alive_opponents(faction : FACTIONS) -> Array[Troop]:
	return alive_enemies if faction == FACTIONS.ALLIES else alive_allies

func on_troop_death(troop : Troop):
	match (troop.faction):
		FACTIONS.ALLIES: alive_allies.erase(troop)
		FACTIONS.ENEMIES: alive_enemies.erase(troop)

func start_fight():
	if !is_fight_started:
		spawner.spawn_troops()
		is_fight_started = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_released("espace"):
		start_fight()

func _physics_process(delta: float) -> void:
	if !is_fight_started: return
	# we make sure all actions are executed before recomputing the targets and states
	execute_troop_actions(delta)
	check_troop_targets()
	check_troop_states()
	check_win_condition()

## execute the action of each troop by alternating between teams
func execute_troop_actions(delta: float):
	var max_troop_amount = max(allies.size(), enemies.size())
	for i in range(max_troop_amount):
		if allies.size() > i:
			var current_troop = allies[i]
			
			current_troop.current_state.process(delta,current_troop.target)
		if enemies.size() > i:
			var current_troop = enemies[i]

			current_troop.current_state.process(delta,current_troop.target)

func check_troop_targets():
	var max_troop_amount = max(allies.size(), enemies.size())
	for i in range(max_troop_amount):
		if allies.size() > i:
			if !allies[i].is_marked_as_dead():
				allies[i].check_target()
		if enemies.size() > i:
			if !enemies[i].is_marked_as_dead():
				enemies[i].check_target()

func check_troop_states():
	var max_troop_amount = max(allies.size(), enemies.size())
	for i in range(max_troop_amount):
		if allies.size() > i:
			if !allies[i].is_marked_as_dead(): 
				allies[i].check_state()
		if enemies.size() > i:
			if !enemies[i].is_marked_as_dead():
				enemies[i].check_state()

func check_win_condition():
	var enemies_alive = get_alive_opponents(FACTIONS.ALLIES)
	var allies_alive = get_alive_opponents(FACTIONS.ENEMIES)
	
	
	if enemies_alive.is_empty() && is_back_to_base(allies_alive):
		win_fight()
		is_fight_started = false
	
	if allies_alive.is_empty() && is_back_to_base(enemies_alive):
		loose_fight()
		is_fight_started = false

func is_back_to_base(alive_troops : Array[Troop]):
	for i in range(alive_troops.size()):
		if alive_troops[i].current_state.get_state_id() != StateMachine.STATES.IDLE:
			return false
	return true

func win_fight():
	UserData.souls += enemies.size()
	SignalBus.on_win.emit()
	UserData.level_number +=1
	take_death_into_account()
	
func take_death_into_account():
	var alive_troops_map : Dictionary[TroopFactory.ROLES, int] = {}
	for alive_troop in get_alive_opponents(FACTIONS.ENEMIES):
		if not alive_troops_map.has(alive_troop.role):
			alive_troops_map[alive_troop.role] = 0
		alive_troops_map[alive_troop.role] +=1
	UserData.troops = alive_troops_map
	
func loose_fight():
	SignalBus.on_loss.emit()

func get_opponents_in_state(faction : FACTIONS, state: StateMachine.STATES) -> Array[Troop]:
	var opps = enemies if faction == FACTIONS.ALLIES else allies
	return opps.filter(func(troop): return troop.current_state.get_state_id() == state)
