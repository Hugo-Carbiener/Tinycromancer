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
		STATES.IDLE: return IdleState.new(troop, "idle")
		STATES.ADVANCE: return AdvanceState.new(troop, "walk")
		STATES.RETREAT: return RetreatState.new(troop, "walk")
		STATES.ATTACK: return AttackState.new(troop, "idle")
		STATES.DEAD: return DeadState.new(troop, "death")
