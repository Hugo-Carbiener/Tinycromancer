class_name AdvanceState extends State

func _init(_troop : Troop, animation : String):
	super(_troop, animation)

func get_next_state() -> StateMachine.STATES:
	if troop.is_dead():
		return StateMachine.STATES.DEAD
		
	if troop.target != null:
		return StateMachine.STATES.ADVANCE if !troop.is_target_in_range() else StateMachine.STATES.ATTACK
	
	if CombatManager.instance.get_alive_opponents(troop.faction).is_empty():
		return StateMachine.STATES.RETREAT 
	
	printerr("Null target while opponents are still alive (from advance state)")
	return StateMachine.STATES.ADVANCE

func on_state_enter(target : Troop):
	super(troop)
	troop.movement_module.reset(target)

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.ADVANCE

func process(delta: float, target : Troop):
	troop.movement_module.process(delta, target)
