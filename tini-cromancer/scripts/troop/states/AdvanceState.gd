class_name AdvanceState extends State

func _init(_troop : Troop):
	super(_troop)

func on_state_enter(target : Troop):
	troop.movement_module.reset(target)

func on_state_exit(target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.ADVANCE

func process(delta: float, target : Troop):
	troop.movement_module.process(delta, target)
