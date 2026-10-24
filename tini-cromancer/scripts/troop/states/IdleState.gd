class_name IdleState extends State

func _init(_troop : Troop, animation : String):
	super(_troop, animation)

func get_next_state() -> StateMachine.STATES:
	if troop.is_dead(): 
		return StateMachine.STATES.DEAD
	
	if troop.target != null:
		return StateMachine.STATES.ADVANCE if !troop.is_target_in_range() else StateMachine.STATES.ATTACK
	
	return StateMachine.STATES.IDLE

func on_state_enter(_target : Troop):
	super(_target)
	troop.movement_module.collision_shape.disabled = true

func on_state_exit(_target : Troop):
	troop.movement_module.collision_shape.disabled = false

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.IDLE

func process(_delta: float, _target : Troop):
	# nothing to do while idle
	pass
