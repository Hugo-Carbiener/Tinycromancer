class_name RetreatState extends State

var is_retreated : bool = false

func _init(_troop : Troop, animation : String):
	super(_troop, animation)

func get_next_state() -> StateMachine.STATES:
	if troop.is_dead(): 
		return StateMachine.STATES.DEAD
	
	if troop.movement_module.navigation_agent.is_target_reached():
		return StateMachine.STATES.IDLE
	 
	return StateMachine.STATES.RETREAT

func on_state_enter(_target : Troop):
	super(_target)
	troop.movement_module.set_destination(troop.movement_module.initial_position)
	troop.movement_module.collision_shape.disabled = true


func on_state_exit(_target : Troop):
	troop.movement_module.collision_shape.disabled = false

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.RETREAT

func process(delta: float, _target : Troop):
	troop.movement_module.process(delta, null)
	if troop.movement_module.navigation_agent.is_target_reached():
		is_retreated = true
