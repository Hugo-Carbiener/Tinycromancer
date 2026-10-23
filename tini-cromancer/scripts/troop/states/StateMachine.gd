class_name StateMachine

enum STATES {
	IDLE,
	ADVANCE,
	RETREAT,
	ATTACK,
	DEAD
}

func get_state_from_id(state : STATES, troop : Troop):
	match(state):
		STATES.IDLE: return IdleState.new(troop)

func get_state_from_context(troop : Troop) -> STATES:
	if troop.is_dead(): return STATES.DEAD
	
	if !troop.target:
		if CombatManager.instance.get_alive_opponents(troop.faction).is_empty():
			return STATES.RETREAT
		else:
			printerr("No target found while enmies are alive when checking states")
			return STATES.IDLE
	
	if troop.is_target_in_range():
		return STATES.ATTACK
	return STATES.ADVANCE
