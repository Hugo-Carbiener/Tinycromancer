class_name IdleState extends State

func _init(_troop : Troop, animation : String):
	super(_troop, animation)

func on_state_exit(_target : Troop):
	pass

func get_state_id() -> StateMachine.STATES:
	return StateMachine.STATES.IDLE

func process(_delta: float, _target : Troop):
	# nothing to do while idle
	pass
