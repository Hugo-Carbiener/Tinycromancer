class_name AttackState extends State

func _init(_troop : Troop, animation : String):
	super(_troop, animation)

func get_next_state() -> StateMachine.STATES:
	if troop.is_dead(): 
		return StateMachine.STATES.DEAD
		
	if troop.target != null:
		return StateMachine.STATES.ADVANCE if !troop.is_target_in_range() else StateMachine.STATES.ATTACK
	
	if CombatManager.instance.get_alive_opponents(troop.faction).is_empty():
		return StateMachine.STATES.RETREAT 
	
	return StateMachine.STATES.ATTACK

func on_state_enter(_target : Troop):
	super(troop)
	troop.combat_module.reset()

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.ATTACK

func process(_delta: float, target : Troop):
	troop.combat_module.process(_delta,target)
