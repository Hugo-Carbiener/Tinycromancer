class_name RetreatState extends State

func _init(_troop : Troop):
	super(_troop)

func on_state_enter(_target : Troop):
	troop.movement_module.set_destination(troop.movement_module.initial_position)

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.RETREAT

func process(delta: float, _target : Troop):
	troop.movement_module.process(delta, null)
