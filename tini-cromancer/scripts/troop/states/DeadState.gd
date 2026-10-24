class_name DeadState extends State

func _init(_troop : Troop, animation : String):
	super(_troop, animation)

func get_next_state() -> StateMachine.STATES:
	return StateMachine.STATES.DEAD

func on_state_enter(_target : Troop):
	super(troop)
	troop.movement_module.collision_shape.disabled = true

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.DEAD

func process(_delta: float, _target : Troop):
	# nothing to do while idle
	pass
